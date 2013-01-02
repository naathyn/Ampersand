namespace :db do
  desc "Populate database with faker data"
  task populate: :environment do
    make_users
    make_relationships
    make_microposts
    make_replies
    make_mailtos
    make_links
    make_likes
    make_captchas
  end
end

def make_users
  bill = User.create!(realname: "Bill Clinton", email: "starmailserver@gmail.com",
  name: "billclinton", password: "monica", password_confirmation: "monica",
  location: "here", bio: "What is here?  Isn't it just there without the t?")
  bill.toggle!(:admin)

  29.times do
    realname = "#{Faker::Name.first_name[0..5]} #{Faker::Name.last_name[0..6]}".gsub(/[^\w+\s]/, "")
    email = Faker::Internet.email
    name = realname.gsub(/\s/, "_").downcase!
    password = "secret"
    location = "#{Faker::Address.city[0..26]}, #{Faker::Address.state[0..16]}"
    bio = Faker::Lorem.sentence

    User.create!(realname: realname, email: email, name: name,
    password: password, password_confirmation: password, location: location, bio: bio)
  end
end

def make_relationships
  300.times do
    followed = User.offset(rand(User.count)).first
    follower = User.offset(rand(User.count)).first
    followed.follow!(follower) unless followed.following?(follower)
    follower.follow!(followed) unless followed.following?(follower)
  end
end

def make_microposts
  200.times do
    user = User.offset(rand(User.count)).first
    content = Faker::Lorem.sentence
    user.microposts.create!(content: content)
  end
end

def make_replies
  200.times do
    user = User.offset(rand(User.count)).first
    follower = User.offset(rand(User.count)).first
    content = Faker::Lorem.sentence
    user.microposts.create!(content: "@#{follower.name} #{content}") unless user == follower
    follower.microposts.create!(content: "@#{user.name} #{content}") unless follower == user
  end
end

def make_mailtos
  5.times do
    user = User.offset(rand(User.count)).first
    content = "#{Faker::Internet.email} #{Faker::Lorem.sentence}"
    user.microposts.create!(content: content)
  end
end

def make_links
  10.times do
    user = User.offset(rand(User.count)).first
    content = "https://rubyrails.herokuapp.com #{Faker::Lorem.sentence}"
    user.microposts.create!(content: content)
  end
end

def make_likes
  300.times do
    user = User.offset(rand(User.count)).first
    share = Micropost.offset(rand(Micropost.count)).first
    user.like!(share) unless user == share.user || user.liked?(share)
  end
end

def make_captchas
  150.times do
    user = User.offset(rand(User.count)).first
    content = Faker::Lorem.sentence
    user.captchas.create!(content: content)
  end
end
