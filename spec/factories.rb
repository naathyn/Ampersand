FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "User #{n}" }
    sequence(:email) { |n| "user_#{n}@example.tld"}   
    password "password"
    password_confirmation "password"
    password "secret"
    password_confirmation "secret"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
   content "Lorem ipsum"
    content "Lorem ipsum"
    user
  end
end
