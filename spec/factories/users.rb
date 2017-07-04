FactoryGirl.define do
  factory :user do
    email "user@gmail.com"
    password "password"
    password_confirmation "password"

    factory :creator do
      email "creator@gmail.com"
      password "password"
      password_confirmation "password"
    end

    factory :manager do
      email "manager@gmail.com"
      password "password"
      password_confirmation "password"
      is_manager true
    end

    trait :admin do
      email "admin@gmail.com"
      is_admin true
    end
  end
end
