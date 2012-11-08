## Getting Started [ Linux :) ]

If you so wish...

    $ git clone git@github.com:naathyn/Ampersand.git amp
    $ cd amp
    $ bundle install
    $ ./populate

`./populate` is a simple, yet handy, little bash script I threw together that will:

* Create both development and test databases
* Migrate and prepare both databases
* Populate the database with sample data as defined in `lib/tasks/population.rake`
* Initialize Guard/Spork and start the Rails Server
* Log this data

Be sure your `database.yml` file is setup correctly before you issue `./populate`

## Getting Started [All Others... >:( ]

    $ git clone git@github.com:naathyn/Ampersand.git amp
    $ cd amp
    $ bundle install
    $ bundle exec rake db:migrate
    $ bundle exec rake db:test:prepare
    $ bundle exec guard
    $ rails s
