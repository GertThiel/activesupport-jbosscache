require 'activesupport'

module ActiveSupport
  module Cache

    class InfinispanError < StandardError; end 

    class InfinispanStore < Store

      VERSION = '0.1.0'

      include_class "java.util.Collections"
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
        @node.remove(key)
      rescue CacheException => e
        logger.error("InfinispanError (#{e}): #{e.message}")
        false
      end

      def delete_matched(matcher, options = nil)
        # don't do any local caching at present, just pass
        # through and let the error happen
        super
        raise "Not supported by Infinispan"
      end

      def exist?(key, options = nil)
        super
        @cache.containsKey(key)
      end


      # These methods aren't available in other AS::Stores.
      # Maybe these should be declared to be private?

      def keys
        @cache.keySet().to_a
      end


      private

        def safeRead(key, options = nil)
          Marshal.load( String.from_java_bytes( @cache.get(key) ) )
        rescue
          nil
        end

        def safeWrite(key, value, options = nil)
          @cache.putAsync(key, Marshal.dump(value).to_java_bytes )
          true
        rescue TypeError => e
          logger.error("TypeError (#{e}): #{e.message}")
          false
        end

    end
  end
end
