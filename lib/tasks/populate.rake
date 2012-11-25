namespace :db do
  desc "Populate database with faker data"
  task populate: :environment do
    make_users
    make_relationships
    make_microposts
    make_replies
    make_links
    make_mailtos
    make_likes
    make_captchas
  end
end

def make_users
  admin = User.create!(realname: "Random Person", email: "starmailserver@gmail.com", name: "thatguy", password: "secret", password_confirmation: "secret", location: "Mamas, Basement", bio: "What is here?  Isn't it just there without the 'T'?")
  admin.toggle!(:admin)
  29.times do |n|
    realname = Faker::Name.name[0..18]
    email = Faker::Internet.email
    name = "fake.member_#{n+1}"
    password = "secret"
    city = Faker::Address.city[0..26]
    state = Faker::Address.state[0..16]
    location = "#{city}, #{state}"
    bio = Faker::Lorem.sentence

    User.create!(realname: realname, email: email, name: name, password: password, password_confirmation: password, location: location, bio: bio)
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[3..10]
  followers = users[2..25]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

def make_microposts
  users = User.all(limit: 10)
  10.times do
    content = Faker::Lorem.sentence
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_replies
  users = User.all
  user = users.first
  followed_users = users[3..8]
  followers = users[2..16]
  5.times do
    content = Faker::Lorem.sentence
    followed_users.each { |followed| user.microposts.create!(content: "@#{followed.name} #{content}") }
    followers.each { |follower| follower.microposts.create!(content: "@#{user.name} #{content}") }
  end
end

def make_links
  users = User.all(limit: 5)
  5.times do
    share = Faker::Lorem.sentence
    link = "https://github.com/naathyn/ampersand"
    content = "#{link} #{share}"
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_mailtos
  users = User.all(limit: 3)
  5.times do
    share = Faker::Lorem.sentence
    link = Faker::Internet.email
    content = "#{link} #{share}"
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_likes
  users = User.all
  user = users.last
  microposts = Micropost.all
  likes = microposts[3..27]
  likes.each { |share| user.like!(share) }
end

def make_captchas
  users = User.all(limit: 10)
  10.times do
    content = Faker::Lorem.sentence
    users.each { |user| user.captchas.create!(content: content) }
  end
end
