# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |i|
  name = Faker::Name.name

  # Users
  user = User.new(
    username: name,
    login:    name.downcase.gsub(/[\ \._]/, '-'),
    password: "password#{i.next}"
  )
  user.save!

  puts 'User done'

  # Posts
  10.times do |j|
    post       = user.posts.new
    post.title = "Post U:#{i.next} P:#{j.next}"
    post.state = [:draft, :published, :deleted].sample
    post.save!

    puts 'Post done'
  end


end

puts 'Total User count: ', User.count
puts 'Total Post count: ', Post.count