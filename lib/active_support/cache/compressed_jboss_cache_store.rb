module ActiveSupport
  module Cache
    class CompressedJbossCacheStore < JbossCacheStore

      private

        def safeRead(key, options = nil)
          Marshal.load( ActiveSupport::Gzip.decompress( String.from_java_bytes( @node.get(key) ) ) )
        rescue
          nil
        end

        def safeWrite(key, value, options = nil)
          @node.put(key, ActiveSupport::Gzip.compress( Marshal.dump(value) ).to_java_bytes )
          true
        rescue TypeError => e
          logger.error("TypeError (#{e}): #{e.message}")
          false
        end

    end
  end
end
