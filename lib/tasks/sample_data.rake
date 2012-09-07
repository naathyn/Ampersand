namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "user@example.tld",
                         password: "secret",
                         password_confirmation: "secret")
    admin.toggle!(:admin)

    99.times do |n|
      name  = Faker::Name.name
      email = "user-#{n+1}@example.tld"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
