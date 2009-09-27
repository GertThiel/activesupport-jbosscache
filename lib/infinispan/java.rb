module Infinispan
  module Java
    include ::Java
    Dir["#{Infinispan::INFINISPAN_HOME}/ext/infinispan/**/*.jar"].sort.each {|l| require l}
    include_package "javax.cache"
  end
end
