FactoryGirl.define do
  factory :profile do
    name "user"
    phonenumber "+84943979669"
    avatar "avatar" 
    user {FactoryGirl.create :user}
    birthday 20.years.ago
    gender 1
    address "address"
    job "programmer"
  end
end
