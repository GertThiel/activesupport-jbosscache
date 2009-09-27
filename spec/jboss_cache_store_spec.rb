require File.join(File.dirname(__FILE__), %w[jboss_cache_store_spec_helper])

describe ActiveSupport::Cache::JbossCacheStore do

  it_should_behave_like "a ActiveSupport::Cache::Store implementation"
  it_should_behave_like "a AS::C::Store implementation supporting useful optional methods"
  it_should_behave_like "a AS::C::Store implementation supporting some MemCacheStore compatible extensions"

  before :all do
    @store = ActiveSupport::Cache::JbossCacheStore.new()
  end

  it "should be the corrent version" do
    ActiveSupport::Cache::JbossCacheStore::VERSION.should eql('0.1.2')
  end

  it "should initialize correctly" do
    @store.class.should == ActiveSupport::Cache::JbossCacheStore
  end

  describe "MemCacheStore compatible extensions" do

    xit "should expire cached data if told so (:expires_in)" do
      @store.write('ExpiringStringKey', 'ExpiringValue', :expires_in => 1.seconds).should be_true
      @store.read('ExpiringStringKey').should == 'ExpiringValue'
      sleep(2)
      @store.read('ExpiringStringKey').should == nil
    end

  end

end
