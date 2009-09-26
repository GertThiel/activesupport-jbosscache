require File.join(File.dirname(__FILE__), %w[jboss_cache_spec_helper])

describe JbossCache do

  it "should have JBOSS_CACHE_HOME defined" do
    defined?(JbossCache::JBOSS_CACHE_HOME).should be_true
  end

end
