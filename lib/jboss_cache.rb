$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'java'

module JbossCache
  unless defined?(JBOSS_CACHE_HOME)
    JBOSS_CACHE_HOME = File.expand_path(File.dirname(__FILE__) + '/..')
  end

  # wraps all native exceptions
  class JbossCacheError < RuntimeError; end
end

require File.join(File.dirname(__FILE__), %w[jboss_cache java])