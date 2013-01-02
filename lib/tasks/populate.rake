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
  admin = User.create!(realname: "Admin Account", email: "starmailserver@gmail.com", name: "admin", password: "secret", password_confirmation: "secret", location: "Ampersand", bio: "Edit me")
  admin.toggle!(:admin)
  29.times do |n|
    first_name = Faker::Name.first_name[0..6]
    last_name = Faker::Name.last_name[0..7]
    fullname = "#{first_name} #{last_name}"
    realname = fullname.gsub(/['.\+]/, "")
    email = Faker::Internet.email
    name = fullname.gsub(/\s+/, "_").downcase!
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
