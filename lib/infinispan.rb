$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'java'

module Infinispan
  unless defined?(INFINISPAN_HOME)
    INFINISPAN_HOME = File.expand_path(File.dirname(__FILE__) + '/..')
  end

  # wraps all native exceptions
  class InfinispanError < RuntimeError; end
end

require File.join(File.dirname(__FILE__), %w[infinispan java])
