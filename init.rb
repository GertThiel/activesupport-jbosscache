$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

if defined?(JRUBY_VERSION)
  require 'lib/active_support/cache/jboss_cache_store'
end
