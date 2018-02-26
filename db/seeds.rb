# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Idea.destroy_all
User.destroy_all

root_user = {
  first_name: 'Jon',
  last_name: 'Snow',
  email: 'jsnow@winterfell.gov',
  password: '123'
};

User.create root_user

20.times do
  User.create({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '123'
  })
end

users = User.all

puts "Created #{users.count} users"
puts "The root user is:\n#{root_user}"

100.times do
  Idea.create({
    title: Faker::ChuckNorris.fact,
    description: Faker::Lorem.paragraph,
    user: users.sample
  })
end

puts "Created #{Idea.count} ideas"
