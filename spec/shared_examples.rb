shared_examples_for "a ActiveSupport::Cache::Store implementation" do

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

end

shared_examples_for "a AS::C::Store implementation supporting useful optional methods" do

  it "should return the keys" do
    @store.clear.should be_true
    @store.write('One', 1).should be_true
    @store.write('Two', 2).should be_true
    @store.keys.sort.should == ['One', 'Two'].sort
  end

  it "should delete key which match a given regular expression" do
    @store.clear.should be_true
    @store.write('A1', 1).should be_true
    @store.write('A2', 2).should be_true
    @store.write('A3', 2).should be_true
    @store.write('B1', 2).should be_true
    @store.write('B2', 2).should be_true
    @store.write('B3', 2).should be_true
    @store.write('C1', 2).should be_true
    @store.write('C2', 2).should be_true
    @store.write('C3', 2).should be_true
    @store.keys.sort.should == ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"].sort
    @store.delete_matched(/3/).should be_true
    @store.keys.sort.should == ["A1", "A2", "B1", "B2", "C1", "C2"].sort
    @store.delete_matched(/A/).should be_true
    @store.keys.sort.should == ["B1", "B2", "C1", "C2"].sort
    @store.delete_matched(/^.$/).should be_true
    @store.keys.sort.should == ["B1", "B2", "C1", "C2"].sort
  end

  it "should remove all cached data if told so" do
    @store.clear.should be_true
    @store.keys.should == []
  end

end

shared_examples_for "a AS::C::Store implementation supporting some MemCacheStore compatible extensions" do

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

end

shared_examples_for "a AS::C::Store implementation supporting all MemCacheStore compatible extensions" do

  it_should_behave_like "a AS::C::Store implementation supporting some MemCacheStore compatible extensions"

  it "should expire cached data if told so (:expires_in)" do
    @store.write('ExpiringStringKey', 'ExpiringValue', :expires_in => 1.seconds).should be_true
    @store.read('ExpiringStringKey').should == 'ExpiringValue'
    sleep(2)
    @store.read('ExpiringStringKey').should == nil
  end

end
