FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "User #{n}" }
<<<<<<< HEAD
    sequence(:email) { |n| "user_#{n}@example.tdl"}   
=======
    sequence(:email) { |n| "user_#{n}@example.com"}   
>>>>>>> settings
    password "secret"
    password_confirmation "secret"

    factory :admin do
      admin true
    end
  end
end
