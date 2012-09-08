namespace :db do
  desc "Sample database"
  task populate: :environment do
    make_users
    make_microposts
<<<<<<< HEAD
    make_relationships
=======
>>>>>>> posting
  end
end

def make_users
<<<<<<< HEAD
  admin = User.create!(name:     "Nathan",
                       email:    "nathan3k@gmail.com",
                       password: "password",
                       password_confirmation: "password")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "nathan3k-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
=======
  admin = User.create!(name: "User",
                       email: "user@example.tld",
                       password: "secret",
                       password_confirmation: "secret")
  admin.toggle!(:admin)
  99.times do |n|
    name = Faker::Name.name
    email = "user-#{n+1}@example.tld"
    password = "password"
    User.create!(name: name,
                 email: email,
>>>>>>> posting
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

