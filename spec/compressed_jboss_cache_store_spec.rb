require File.join(File.dirname(__FILE__), %w[compressed_jboss_cache_store_spec_helper])

describe ActiveSupport::Cache::CompressedJbossCacheStore do

  before :all do
    @store = ActiveSupport::Cache::CompressedJbossCacheStore.new()
  end

  before :each do
  end

  it "should be the corrent version" do
    ActiveSupport::Cache::CompressedJbossCacheStore::VERSION.should eql('0.1.1')
  end

  it "should initialize correctly" do
    @store.class.should == ActiveSupport::Cache::CompressedJbossCacheStore
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
