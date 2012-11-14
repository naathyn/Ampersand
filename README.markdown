Getting Started (Standard)
==========================

    $ git clone git@github.com:naathyn/Ampersand.git amp
    $ cd amp
    $ bundle install
    $ bundle exec rake db:migrate
    $ bundle exec rake db:test:prepare
    $ bundle exec guard
    $ rails s

Getting Started (Optional)
==========================

    $ git clone git@github.com:naathyn/Ampersand.git amp
    $ cd amp
    $ bundle install
    $ . populate

Populate
--------

`populate` is a simple, yet handy, little shell script I threw together that will:

* Setup both development and test databases (alternatively reset them if already created)
* Populate the database with sample data as defined in `lib/tasks/populate.rake`
* Prepare both databases
* Initialize guard/spork. start the rails server. take you to your app
* Log this data

It can be used to setup the database for the first time as well as simply testing sample data from `lib/tasks/populate.rake`.

**Notice**: `server_guard.sh` specifies `gnome-terminal`, therefore the script is _pretty_ limited when it comes to compatibility. If you are running a Linux distrobution with said-terminal, it should be fine. Otherwise, you can safely ignore this optional setup _or_ make it work for you and your machine. It was primarily created for myself while testing.
