FactoryGirl.define do
  factory :group do
    creator
    category
    title "Eating"
    time 2.days.from_now
    address "Ha Noi"
    longitude 12.12125425
    latitude -55.1241232
    size 10
  end
end
