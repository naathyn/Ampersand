# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
# cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP ADMIN LOGIN'
user = User.create! :realname => 'Admin Account', :email => 'starmailserver@gmail.com', :name => 'admin', :password => 'secret', :password_confirmation => 'secret'
user.toggle!(:admin)
puts 'Admin created: ' << user.realname
