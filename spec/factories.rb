FactoryGirl.define do
  factory :user do
    sequence(:realname) { |n| "Nathan Couch #{n}" }
    sequence(:email) { |n| "nathan3k_#{n}@gmail.com"}
    sequence(:name) { |n| "naathyn#{n}" }
    password "secret"
    password_confirmation "secret"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "I got plenty moneyyy"
    user
  end

  factory :user_reply, class: User do |user|
    user.realname "Alan Couch"
    user.email "hatchiebird@gmail.com"
    user.name "hatchiebird"
    user.password "secret"
    user.password_confirmation "secret"
  end
end
