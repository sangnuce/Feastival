FactoryGirl.define do
  factory :user do
    email "user@gmail.com"
    password "password"
    password_confirmation "password"
    
    trait :admin do
      email "admin@gmail.com"
      is_admin true
    end
  end
end
