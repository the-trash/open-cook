# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |i|
  name = Faker::Name.name

  User.create!(
      username: name,
      login:    name.downcase.gsub(/[\ \._]/, '-'),
      password: "password#{i.next}"
  )

  p 'User done'
end

p 'Total user count', User.count