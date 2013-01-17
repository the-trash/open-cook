# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all

# cleanup
Hub.destroy_all
Post.destroy_all
Blog.destroy_all
Recipe.destroy_all
Article.destroy_all

puts 'cleanup done'

russ = " Русский `^@#$&№%*«»!?.,:;{}()<>+|/~ тёст -- "

(3..8).to_a.sample.times do |i|
  name  = Faker::Name.name
  login = name.downcase.gsub(/[\ \._]/, '-')
  email = "#{login}@gmail.com"
  
  # Users
  user = User.new(
    username: name,
    login:    login + russ,
    email:    email,
    password: "password#{i.next}"
  )
  user.save!

  puts "=> User #{i} done"

  Hub
  (3..8).to_a.sample.times do |h|
    hub_type = [:pages, :posts, :articles, :recipes, :blogs].sample

    hub          = user.hubs.new
    hub.title    = "Hub #{hub_type}  #{russ} (U:#{i.next} No:#{h.next})"
    hub.state    = [:draft, :published, :deleted].sample
    hub.hub_type = hub_type
    hub.save!

    puts "Hub #{h.next} done"

    # create nested objects
    (3..8).to_a.sample.times do |j|
      obj       = hub.send(hub_type).new
      obj.user  = user
      obj.title = "#{hub_type}  #{russ} U:#{i.next} No:#{j.next}"
      obj.state = [:draft, :published, :deleted].sample
      obj.save!

      puts "#{hub_type} U:#{i.next} No:#{j.next} - done!"
      parent_obj = obj

      puts "SUB CREATING"
      (3..8).to_a.sample.times do |k|
        obj       = hub.send(hub_type).new
        obj.user  = user
        obj.title = "#{hub_type}  #{russ} U:#{i.next} No:#{j.next}#{k.next}"
        obj.state = [:draft, :published, :deleted].sample
        obj.save!

        obj.move_to_child_of(parent_obj)

        puts "#{hub_type} U:#{i.next} No:#{j.next}#{k.next} - done!"
      end

    end
  end
end

puts "Total User count: #{User.count}"
puts "Total Post count: #{Page.count}"
puts "Total Post count: #{Post.count}"
puts "Total Blog count: #{Blog.count}"
puts "Total Recipes count: #{Recipe.count}"
puts "Total Article count: #{Article.count}"