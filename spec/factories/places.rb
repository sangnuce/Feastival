FactoryGirl.define do
  factory :place do
    manager
    category
    title "Test Restaurant"
    address "Test Restaurant Address"
    longitude 12.2135351
    latitude 11.12346436
    is_approved true
  end
end
