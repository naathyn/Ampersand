namespace :db do
  desc "Populate database with faker data"
  task populate: :environment do
    make_admin
    make_users
    make_relationships
    make_microposts
  end
end

def make_admin
  me = User.create!(realname: "Nathan Couch", email: "nathan3k@gmail.com", name: "naathyn", password: "secret", password_confirmation: "secret", location: "Jackson, Tennessee", bio: "I love everything beautiful.")
  me.toggle!(:admin)
end

def make_users
  60.times do |n|
    realname = Faker::Name.name[0..18]
    email = Faker::Internet.email
    name = "ghost_of_me#{n+1}"
    password = "secret"
    city = Faker::Address.city[0..26]
    state = Faker::Address.state[0..16]
    location = "#{city}, #{state}"
    bio = Faker::Lorem.sentence(3)

    User.create!(realname: realname, email: email, name: name, password: password, password_confirmation: password, location: location, bio: bio)
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[3..15]
  followers = users[2..30]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

def make_microposts
  users = User.all(limit: 15)
  10.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end
