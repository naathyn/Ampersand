## Getting Started (General Usage)

If you so wish...

    $ git clone git@github.com:naathyn/Ampersand.git amp
    $ cd amp
    $ bundle install
    $ bundle exec rake db:migrate
    $ bundle exec rake db:test:prepare
    $ bundle exec guard
    $ rails s

## Getting Started [ Specified Linux Distros ]

__Note__: `server_guard.sh` specifies `gnome-terminal` as the terminal, therefore this bash script really limits compatibility. If you are running a Linux distrobution with the Gnome desktop, it should be fine. Otherwise, I wouldn't waste my time.

    $ git clone git@github.com:naathyn/Ampersand.git amp
    $ cd amp
    $ bundle install
    $ ./populate

`./populate` is a simple, yet handy, little (_hardly-compatible_) shell script I threw together that will:

* Create both development and test databases
* Migrate and prepare both databases
* Populate the database with sample data as defined in `lib/tasks/population.rake`
* Initialize Guard/Spork and start the Rails Server
* Log this data

The code was really for fun, utilizing bleek time learning shell. But hey, if it works for you, _or you can make it work for you_, use it!

If you _can_ use it, be sure your `database.yml` file is setup correctly before you issue `./populate`

