require 'activesupport'

module ActiveSupport
  module Cache

    class JbossCacheError < StandardError; end 

    class JbossCacheStore < Store

      VERSION = '0.1.0'

      include_class "org.jboss.cache.Cache"
      include_class "org.jboss.cache.CacheFactory"
      include_class "org.jboss.cache.Fqn"
      include_class "org.jboss.cache.Node"

      def initialize(options = {})
        @node = org.jboss.cache.DefaultCacheFactory.new().createCache().
                  getRoot().addChild( org.jboss.cache.Fqn.fromString('RubyJbossCacheStore') )
      end

      def read(key, options = nil)
        super
        marshalled_bytes = @node.get(key)
        value = Marshal.load( String.from_java_bytes( marshalled_bytes ) ) rescue nil
        value
      rescue JbossCacheError => e
        logger.error("JbossCacheError (#{e}): #{e.message}")
        false
      end

      def write(key, value, options = {})
        super
        marshalled_string = Marshal.dump(value)
        marshalled_bytes = marshalled_string.to_java_bytes
        @node.put(key, marshalled_bytes)
        true
      rescue TypeError => e
        logger.error("TypeError (#{e}): #{e.message}")
        false
      rescue JbossCacheError => e
        logger.error("JbossCacheError (#{e}): #{e.message}")
        false
      end

      def delete(key, options = nil)
        super
        @node.remove(key)
      rescue JbossCacheError => e
        logger.error("JbossCacheError (#{e}): #{e.message}")
        false
      end

      def delete_matched(matcher, options = nil)
        # don't do any local caching at present, just pass
        # through and let the error happen
        super
        raise "Not supported by JBoss Cache"
      end

      def exist?(key, options = nil)
        super
        keys.include? key
      end


      # These methods aren't available in other AS::Stores.
      # Maybe these should be declared to be private?

      def keys
        @node.getKeys().to_a
      end

    end
  end
end
