# RubyThere

A site for events of interest to Rubyists

## Installation instructions

  Install gems

    $ bundle install
  
  Setup config files

    * Copy the database_example.yml to database.yml with whatever changes you want locally 
    * Copy the app_config_example.yml to app_config.yml with whatever changes you want locally
    
  Setup the databases

    $ rake db:create:all
    $ rake db:schema:load

  Setup Sphinx:

    You may need to install Sphinx: http://freelancing-god.github.com/ts/en/
    Rebuild indexes and restart:

    $ rake ts:rebuild
    

## Contributing to rubythere

- Run "rake spec" to run the Rspec unit test suite

- Run "rake cucumber" to run the integration test suite

(Old shoulda based functional tests will be phased out with more integration tests)

* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it

### If you want to contribute an enhancement or a fix:

  * Fork the project on github.
  * Make your changes with tests.
  * Commit the changes without making changes to the Rakefile or any other files that aren't related to your enhancement or fix
  * Send a pull request.