require 'rubygems'
require 'spec'

require "#{File.dirname(__FILE__)}/../lib/jboss_cache_store"

50.times do puts "\n"; end

raise RuntimeError, 'JRuby is required' unless defined?(JRUBY_VERSION)
#aise RuntimeError, 'JCache is required' unless defined?(org.jboss.cache)

describe ActiveSupport::Cache::JbossCacheStore do

  before :all do
    @store = ActiveSupport::Cache::JbossCacheStore.new()
  end

  before :each do
  end

  it "should be the corrent version" do
    ActiveSupport::Cache::JbossCacheStore::VERSION.should eql('0.1.0')
  end

  it "should initialize correctly" do
    @store.class.should == ActiveSupport::Cache::JbossCacheStore
  end

  it "should read exactly the same string which was written to the cache" do
    @store.write('StringKey', 'FirstValue').should be_true
    @store.read('StringKey').should == 'FirstValue'
  end

  it "should read exactly the same hash which was written to the cache" do
    firstHash = {
      :firstHashKey => 'firstHashValue',
      :secondHashKey => 1234567890
    }
    @store.write('HashKey', firstHash).should be_true
    @store.read('HashKey').should == firstHash
  end

  it "should report whether some key exists" do
    @store.exist?('StringKey').should be_true
    @store.exist?('HashKey').should be_true
  end

  it "should return the keys" do
    @store.keys.should == ['StringKey', 'HashKey'].sort
  end

end
