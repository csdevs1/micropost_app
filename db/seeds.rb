# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "Admin User", username: "Admin", email: "admin@example.com", password: "password", password_confirmation: "password", admin: true, activated: true, activated_at: Time.zone.now)

99.times do |n|
    name = Faker::Name.name
    username = "User#{n+1}"
    email = "example-#{n+1}@micropostapp.org"
    password = "password"
    User.create!(name: name, username: username, email: email, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end

users = User.order(:created_at).tae(6)
50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
end