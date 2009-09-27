require File.join(File.dirname(__FILE__), %w[compressed_infinispan_store_spec_helper])

describe ActiveSupport::Cache::CompressedInfinispanStore do

  it_should_behave_like "a ActiveSupport::Cache::Store implementation"
  it_should_behave_like "a AS::C::Store implementation supporting useful optional methods"
  it_should_behave_like "a AS::C::Store implementation supporting all MemCacheStore compatible extensions"

  before :all do
    @store = ActiveSupport::Cache::CompressedInfinispanStore.new()
  end

  it "should be the corrent version" do
    ActiveSupport::Cache::CompressedInfinispanStore::VERSION.should eql('0.1.1')
  end

  it "should initialize correctly" do
    @store.class.should == ActiveSupport::Cache::CompressedInfinispanStore
  end

end
