module ActiveSupport
  module Cache
    class CompressedInfinispanStore < InfinispanStore

      private

        def safeRead(key, options = nil)
          Marshal.load( ActiveSupport::Gzip.decompress( String.from_java_bytes( @cache.get(key) ) ) )
        rescue
          nil
        end

        def safeWrite(key, value, options = nil)
          putMethod = options && options[:unless_exist] ? :putIfAbsentAsync : :putAsync

          options && options[:expires_in] ? @cache.send(putMethod, key, ActiveSupport::Gzip.compress( Marshal.dump(value) ).to_java_bytes, expires_in(options).to_i, java.util.concurrent.TimeUnit::SECONDS) \
                                          : @cache.send(putMethod, key, ActiveSupport::Gzip.compress( Marshal.dump(value) ).to_java_bytes)
          true
        rescue TypeError => e
          logger.error("TypeError (#{e}): #{e.message}")
          false
        end

    end
  end
end
