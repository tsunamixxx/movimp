# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


100.times do |n|
  email = Faker::Internet.email
  password = "password"
  #aa = Faker::Address.city
  #bb = Faker::Address.street_name
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: Faker::Name.name,
               #uid: aa,
               #provider: bb
               )
end

i = 0
n = User.last.id
while i < 100
  Review.create(
    title: "あああ",
    content: "hoge",
    user_id: n
  )
  n = n - 1
  i = i + 1
end
