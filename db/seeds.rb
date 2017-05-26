# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


("a".."j").each do |a|
  Category.create(
    name: "#{a}*6"
  )
end

("a".."j").each do |a|
  User.create(
    email: "#{a}@gmail.com",
    password: "123456",
    password_confirmation: "123456"
  )
end

(1..10).each do |a|
user = User.find(a)
user.owned_groups.create(
  title: "Lorem Ipsum dolor si amet",
  address: "Arem lipsum Lodor A simet",
  size: 10,
  time: Time.now,
  category_id: a
)
end
