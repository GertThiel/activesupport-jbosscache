require 'activesupport'

module ActiveSupport
  module Cache

    class InfinispanError < StandardError; end 

    class InfinispanStore < Store

      VERSION = '0.1.1'

      include_class "java.util.concurrent.TimeUnit"
      include_class "org.infinispan.CacheException"
      include_class "org.infinispan.manager.DefaultCacheManager"

      def initialize(options = {})
        cacheManager = org.infinispan.manager.DefaultCacheManager.new()
        @cache = cacheManager.get_cache()
      end

      def read(key, options = nil)
        super
        safeRead(key, options)
      rescue CacheException => e
        logger.error("InfinispanError (#{e}): #{e.message}")
        false
      end

      def write(key, value, options = {})
        super
        safeWrite(key, value, options)
      rescue CacheException => e
        logger.error("InfinispanError (#{e}): #{e.message}")
        false
      end

      def delete(key, options = nil)
        super
        @cache.removeAsync(key)
      rescue CacheException => e
        logger.error("InfinispanError (#{e}): #{e.message}")
        false
      end

      def exist?(key, options = nil)
        super
        @cache.containsKey(key)
      end


      # These methods aren't available in every AS::Store implementation:

      def read_multi(*keys)
        keys.flatten.inject({}) do |results, key|
          if (value = read(key))
            results[key] = value
          end
          results
        end
      end

      def delete_matched(matcher, options = nil)
        super
        keys.map { |key| delete(key, options) if key =~ matcher }
        true
      rescue CacheException => e
        logger.error("InfinispanError (#{e}): #{e.message}")
        false
      end

      def keys
        @cache.keySet().to_a
      end

      def clear
        @cache.clearAsync()
        true
      end


      private

        def safeRead(key, options = nil)
          Marshal.load( String.from_java_bytes( @cache.get(key) ) )
        rescue
          nil
        end

        def safeWrite(key, value, options = nil)
          putMethod = options && options[:unless_exist] ? :putIfAbsentAsync : :putAsync

          options && options[:expires_in] ? @cache.send(putMethod, key, Marshal.dump(value).to_java_bytes, expires_in(options).to_i, java.util.concurrent.TimeUnit::SECONDS) \
                                          : @cache.send(putMethod, key, Marshal.dump(value).to_java_bytes)
          true
        rescue TypeError => e
          logger.error("TypeError (#{e}): #{e.message}")
          false
        end

    end
  end
end
