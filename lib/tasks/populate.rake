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
    make_blogs
    make_blog_comments
  end
end

def make_users
  puts "\n\nCREATING 30 USERS..."

  bill = User.create!(
    realname: "Bill Clinton",
    email: "starmailserver@gmail.com",
    name: "billclinton",
    password: "monica",
    password_confirmation: "monica",
    location: "here", bio: "What is here?  Isn't it just there without the t?"
  )
  bill.toggle!(:admin)

  29.times do
    realname = "#{Faker::Name.first_name[0..5]} #{Faker::Name.last_name[0..6]}".gsub(/[^\w+\s]/, "")
    email = Faker::Internet.email
    name = realname.gsub(/\s/, "_").downcase!
    password = "secret"
    location = "#{Faker::Address.city[0..26]}, #{Faker::Address.state[0..16]}"
    bio = Faker::Lorem.sentence

    User.create!(realname: realname,
      email: email,
      name: name,
      password: password,
      password_confirmation: password,
      location: location,
      bio: bio
    )
  end

  puts "COMPLETE!\n\n"
end

def make_relationships
  puts "CREATING 300 FOLLOWS..."

  300.times do
    followed = User.offset(rand(User.count)).first
    follower = User.offset(rand(User.count)).first

    followed.follow!(follower) unless followed.following?(follower)
    follower.follow!(followed) unless followed.following?(follower)
  end

  puts "COMPLETE!\n\n"
end

def make_microposts
  puts "CREATING 200 POSTS..."

  200.times do
    user = User.offset(rand(User.count)).first
    content = Faker::Lorem.sentence

    begin
      user.microposts.create!(
        content: content
      )
    rescue ActiveRecord::RecordNotUnique
    end
  end

  puts "COMPLETE!\n\n"
end

def make_replies
  puts "CREATING 200 REPLIES..."

  200.times do
    user = User.offset(rand(User.count)).first
    follower = User.offset(rand(User.count)).first
    content = Faker::Lorem.sentence

    begin
      user.microposts.create!(
        content: "@#{follower.name} #{content}"
      ) unless user == follower
      follower.microposts.create!(
        content: "@#{user.name} #{content}"
      ) unless follower == user
    rescue ActiveRecord::RecordNotUnique
    end
  end

  puts "COMPLETE!\n\n"
end

def make_mailtos
  puts "CREATING 5 MAILTOS..."

  5.times do
    user = User.offset(rand(User.count)).first
    content = "#{Faker::Internet.email} #{Faker::Lorem.sentence}"

    begin
      user.microposts.create!(
        content: content
      )
    rescue ActiveRecord::RecordNotUnique
    end
  end

  puts "COMPLETE!\n\n"
end

def make_links
  puts "CREATING 10 HYPERLINKS..."

  10.times do
    user = User.offset(rand(User.count)).first
    content = "https://rubyrails.herokuapp.com #{Faker::Lorem.sentence}"

    begin
      user.microposts.create!(
        content: content
      )
    rescue ActiveRecord::RecordNotUnique
    end
  end

  puts "COMPLETE!\n\n"
end

def make_likes
  puts "CREATING 300 LIKES..."

  300.times do
    user = User.offset(rand(User.count)).first
    share = Micropost.offset(rand(Micropost.count)).first

    user.like!(share) unless user == share.user || share.liked_by?(user)
  end

  puts "COMPLETE!\n\n"
end

def make_captchas
  puts "CREATING 150 CAPTCHAS.."

  150.times do
    user = User.offset(rand(User.count)).first
    content = Faker::Lorem.sentence

    user.captchas.create!(
      content: content
    )
  end

  puts "COMPLETE!\n\n"
end

def make_blogs
  puts "CREATING 30 BLOG ENTRIES..."

  user = User.first!
  30.times do
    title = Faker::Lorem.word
    tag_names = Faker::Lorem.sentence.split.uniq.join(', ')
    content = Faker::Lorem.sentence(500)

    begin
      user.blogs.create!(
        title: title,
        content: content,
        tag_names: tag_names
      )
    rescue ActiveRecord::RecordNotUnique
    end
  end

  puts "COMPLETE!\n\n"
end

def make_blog_comments
  puts "CREATING 90 BLOG COMMENTS..."

  90.times do
    user = User.offset(rand(User.count)).first
    blog = Blog.offset(rand(Blog.count)).first
    content = Faker::Lorem.sentence(5)

    user.comments.create!(
      blog_id: blog.id,
      content: content
    ) unless user == blog.user
  end

  puts "ALL DONE!\n\n"
end
