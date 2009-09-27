require File.join(File.dirname(__FILE__), %w[jboss_cache_store_spec_helper])

describe ActiveSupport::Cache::JbossCacheStore do

  before :all do
    @store = ActiveSupport::Cache::JbossCacheStore.new()
  end

  before :each do
  end

  it "should be the corrent version" do
    ActiveSupport::Cache::JbossCacheStore::VERSION.should eql('0.1.1')
  end

  it "should initialize correctly" do
    @store.class.should == ActiveSupport::Cache::JbossCacheStore
  end

  it "should read exactly the same string which was written to the cache" do
    @store.write('StringKey', 'FirstValue').should be_true
    @store.read('StringKey').should == 'FirstValue'
  end

  it "should read exactly the same integer which was written to the cache" do
    @store.write('StringKey', 1234567890).should be_true
    @store.read('StringKey').should == 1234567890
  end

  it "should read exactly the same hash which was written to the cache" do
    firstHash = {
      :firstHashKey => 'firstHashValue',
      :secondHashKey => 1234567890
    }
    @store.write('HashKey', firstHash).should be_true
    @store.read('HashKey').should == firstHash
  end

  it "should read exactly the same nil which was written to the cache" do
    firstNil = nil
    @store.write('HashKey', firstNil).should be_true
    @store.read('HashKey').should == firstNil
  end

  it "should report whether some key exists" do
    @store.exist?('StringKey').should be_true
    @store.exist?('HashKey').should be_true
    @store.exist?('NonExistantKey').should be_false
  end

  describe "Optional methods" do

    it "should return the keys" do
      @store.clear.should be_true
      @store.write('One', 1).should be_true
      @store.write('Two', 2).should be_true
      @store.keys.should == ['One', 'Two'].sort
    end

    it "should remove all cached data if told so" do
      @store.clear.should be_true
      @store.keys.should == []
    end

  end

  describe "MemCacheStore compatible extensions" do

    it "should be able to read multiple cached data at a time" do
      @store.write('OneKeyOfMany', 'OneValueKeyOfMany').should be_true
      @store.write('AnotherKeyOfMany', 1234567890).should be_true
      @store.read_multi('OneKeyOfMany', 'AnotherKeyOfMany').should == {'OneKeyOfMany' => 'OneValueKeyOfMany', 'AnotherKeyOfMany' => 1234567890}
      @store.read_multi(['OneKeyOfMany', 'AnotherKeyOfMany']).should == {'OneKeyOfMany' => 'OneValueKeyOfMany', 'AnotherKeyOfMany' => 1234567890}
      @store.read_multi('NonExistingKeyOfMany').should == {}
      @store.read_multi('OneKeyOfMany', 'NonExistingKeyOfMany', 'AnotherKeyOfMany').should == {'OneKeyOfMany' => 'OneValueKeyOfMany', 'AnotherKeyOfMany' => 1234567890}
    end

    it "should not overwrite cached data if told so (:unless_exist)" do
      @store.write('InNeedOfProtectionKey', 'InNeedOfProtectionValue').should be_true
      @store.read('InNeedOfProtectionKey').should == 'InNeedOfProtectionValue'
      @store.write('InNeedOfProtectionKey', 'ReplacingTheInNeedOfProtectionValue', :unless_exist => true).should be_true
      @store.read('InNeedOfProtectionKey').should == 'InNeedOfProtectionValue'
    end

    xit "should expire cached data if told so (:expires_in)" do
      @store.write('ExpiringStringKey', 'ExpiringValue', :expires_in => 1.seconds).should be_true
      @store.read('ExpiringStringKey').should == 'ExpiringValue'
      sleep(2)
      @store.read('ExpiringStringKey').should == nil
    end

  end

end
