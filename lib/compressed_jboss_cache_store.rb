$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

if defined?(JRUBY_VERSION)
  require 'java'
  require File.join(File.dirname(__FILE__), %w[jboss_cache])
  require File.join(File.dirname(__FILE__), %w[active_support cache jboss_cache_store])
  require File.join(File.dirname(__FILE__), %w[active_support cache compressed_jboss_cache_store])
end
