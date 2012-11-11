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
    $ . setup

The Setup Script
----------------

`. setup` is a simple, yet handy, little shell script I threw together that will:

* Create both development and test databases
* Migrate and prepare both databases
* Populate the database with sample data as defined in `lib/tasks/populate.rake`
* Initialize Guard/Spork and start the Rails Server
* Log this data

**Notice About the Scripts**: `server_guard.sh` specifies `gnome-terminal`, therefore both ` . populate` and `. setup` are really limited when it comes to compatibility. If you are running a Linux distrobution with said-terminal, it should be fine. Otherwise, I wouldn't waste my time.

The Populate Script
-------------------

Likewise, `. populate` is similar to `. setup`, although is meant to be used once you have your database set up. This script will:

* Reset the database
* Populate the database with sample data as defined in `lib/tasks/populate.rake`
* Migrate the database
* Initialize Guard/Spork and start the Rails Server
* Log this data

In other words, you should use it if you modify `lib/tasks/populate.rake` and wish to populate its data.
