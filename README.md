ActiveSupport::Cache::JbossCacheStore
=====================================

This is ActiveSupport::Cache::JbossCacheStore, an ActiveSupport::Cache::Store
implementation which uses [JBoss Cache](http://jboss.org/jbosscache/)
available with [JBoss Application Server](http://jboss.org/jbossas/)s
like [TorqueBox](http://torquebox.org/) (formerly known as
[JBoss-Rails](http://oddthesis.org/theses/jboss-rails/projects/jboss-rails)).

It has been tested with Ruby on Rails 2.3.4 and TorqueBox 1.0.0.Beta15 which
bundles JRuby 1.3.1 with JBoss AS 5.1.0.GA and JBossCache 'Malagueta' 3.2.0.GA.


JBoss Cache
-----------

JBoss Cache is usually shipped with every binary JBoss AS distribution and
configured in the `all`-configuration.


The JBoss Cache library and dependant JAR files
-----------------------------------------------

The JBoss Cache library is party of JBoss AS and hence all required files
should be installed and configured with that.


Installation
------------

This package can be installed like any regular Rails plug-in:

    script/plugin install git://github.com/GertThiel/activesupport-jbosscache.git


ActiveSupport::Cache::JbossCacheStore
-------------------------------------

Either add a line to your config/environment.rb file

    config.cache_store = :jboss_cache_store

or create a separate initializer (e.g. config/initializers/cache.rb) with

    ActionController::Base.cache_store = :jboss_cache_store


Test Suite
----------

ActiveSupport::Cache::JbossCacheStore comes with a spec. You need RSpec to run
the tests. On the other hand, you don't need the application server.

A binary JRuby distribution with the activesupport gem installed is enough.

    jruby -S spec spec/jboss_cache_store_spec.rb

<del>The JBoss Cache library is included in this distribution.</del>


License
-------

ActiveSupport::Cache::JbossCacheStore is licensed under a MIT license.
