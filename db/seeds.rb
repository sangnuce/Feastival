# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create name: "Sang trọng"
Category.create name: "Nhậu"
Category.create name: "Bình dân"
Category.create name: "Bar/Pub"
Category.create name: "Buffet"
Category.create name: "Lẩu"
Category.create name: "Cafe/Dessert"
Category.create name: "Beer Club"




User.create(
  email:"admin@gmail.com",
  password:"123456",
  password_confirmation:"123456",
  is_admin: true,
  profile_attributes: {
    name:"Admin",
    gender: 1,
    birthday: Time.now,
    address: "Framgia lab 434 Tran Khat Chan",
    job: "Trainee",
    phonenumber: "0943979669",
    description: "Admin"
  }
)

User.create(
  email:"manager@gmail.com",
  password:"123456",
  password_confirmation:"123456",
  is_manager: true,
  profile_attributes: {
    name:"Manager",
    gender: 1,
    birthday: Time.now,
    address: "Framgia lab 434 Tran Khat Chan",
    job: "Trainee",
    phonenumber: "0943979669",
    description: "Manager"
  }
)


("a".."z").each do |a|
  User.create(
    email: "#{a}@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    profile_attributes: {
      name: Faker::Name.unique.name,
      gender: 1,
      birthday: Faker::Date.birthday(18, 65),
      address: Faker::Address.street_address,
      job: Faker::Job.title,
      phonenumber: Faker::PhoneNumber.cell_phone,
      description: Faker::Lorem.sentence(5),
    }
  )
end

20.times do
  Group.create(
    title: Faker::Lorem.sentence(1),
    time: Faker::Time.between(5.days.ago, 2.days.ago, :afternoon),
    address: Faker::Address.street_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    creator_id: rand(2..10),
    category_id: rand(1..4),
    size: rand(2..12),
  )
end

Group.all.each do |group|
  GroupUser.create(group_id: group.id, user_id: group.creator_id)
end

10.times do
  Place.create(
    manager_id: 2,
    category_id: 1,
    title: Faker::Lorem.sentence(1),
    address: Faker::Address.street_address
  )
end
