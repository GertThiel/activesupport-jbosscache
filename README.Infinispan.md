ActiveSupport::Cache::InfinispanStore
=====================================

This is ActiveSupport::Cache::InfinispanStore, an ActiveSupport::Cache::Store
implementation which uses [Infinispan](http://www.jboss.org/infinispan/).

It has been tested with JRuby 1.3.1 and Infinispan 'Starobrno' 4.0.0.Beta1.


Infinispan
----------

ActiveSupport::Cache::InfinispanStore writes asynchronously to the cache. So
putting stuff into the cache should not block your application.


The Infinispan library and dependant JAR files
----------------------------------------------


Installation
------------

This package can be installed like any regular Rails plug-in:

    script/plugin install git://github.com/GertThiel/activesupport-jbosscache.git


ActiveSupport::Cache::InfinispanStore
-------------------------------------

Either add a line to your config/environment.rb file like

    require File.join(RAILS_ROOT,
        %w[vendor plugin activesupport-jbosscache lib infinispan_store])

    config.cache_store = :infinispan_store

or create a separate initializer (e.g. config/initializers/cache.rb) with

    require File.join(RAILS_ROOT,
        %w[vendor plugin activesupport-jbosscache lib infinispan_store])

    ActionController::Base.cache_store = :infinispan_store


ActiveSupport::Cache::CompressedInfinispanStore
-----------------------------------------------

The CompressedInfinispanStore uses ActiveSupport::Gzip to compress the
cached data. Besides that it behaves exactly as the InfinispanStore.

If you want to use this store either add a line to your config/environment.rb
file like

    require File.join(RAILS_ROOT,
        %w[vendor plugin activesupport-jbosscache lib compressed_infinispan_store])

    config.cache_store = :compressed_infinispan_store

or create a separate initializer (e.g. config/initializers/cache.rb) with

    require File.join(RAILS_ROOT,
        %w[vendor plugin activesupport-jbosscache lib compressed_infinispan_store])

    ActionController::Base.cache_store = :compressed_infinispan_store


Test Suite
----------

ActiveSupport::Cache::InfinispanStore comes with a spec. You need RSpec to run
the tests. On the other hand, you don't need the application server.

A binary JRuby distribution with the activesupport gem installed is enough.

    jruby -S spec spec/infinispan_store_spec.rb
    jruby -S spec spec/compressed_infinispan_store_spec.rb

<del>The Infinispan library is included in this distribution.</del>


License
-------

ActiveSupport::Cache::InfinispanStore is licensed under a MIT license.
