module JbossCache
  module Java
    include ::Java
    Dir["#{JbossCache::JBOSS_CACHE_HOME}/ext/jboss_cache/**/*.jar"].sort.each {|l| require l}
    include_package "org.jboss.cache"
  end
end
