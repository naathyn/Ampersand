namespace :db do
  desc "Sample database"
  task populate: :environment do
    make_users
    make_microposts
  end
end

def make_users
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
