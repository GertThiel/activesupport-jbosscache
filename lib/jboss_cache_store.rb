$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

if defined?(JRUBY_VERSION) ### && defined?(org.jboss.cache)
  require 'java'
  require 'jboss_cache'
  require 'active_support/cache/jboss_cache_store' 
end

module ActiveSupport
  module Cache
    class JbossCacheStore
      VERSION = '0.1.0'
    end
  end 
end
