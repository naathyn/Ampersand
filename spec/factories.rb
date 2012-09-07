FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "User #{n}" }
    sequence(:email) { |n| "user_#{n}@example.tdl"}   
    password "secret"
    password_confirmation "secret"

    factory :admin do
      admin true
    end
  end
end
