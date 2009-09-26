require 'rubygems'
require 'spec'
require 'java'

require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib jboss_cache]))

include JbossCache
include JbossCache::Java

Spec::Runner.configure do |config|
  #config.mock_with :mocha
end
