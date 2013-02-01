# # encoding: UTF-8

User.destroy_all
Hub.destroy_all
Recipe.destroy_all

5.times do |i|
  name  = Faker::Name.name
  login = name.downcase.gsub(/[\ \._]/, '-')
  email = "#{login}@gmail.com"

  user = User.create!(
    username: name,
    login:    login,
    email:    email,
    password: "password#{i.next}"
  )

  puts "User #{i.next} created"
end

User.all.each_with_index do |user, u|
  10.times do |m|
    hub = user.hubs.create!(
      title: "Menu #{m.next} (u:#{u.next})",
      hub_type: :menu
    )

    hub.update_attribute(:state, [:draft, :published].sample)
    puts "Menu u:#{u.next} m:#{m.next} created"

    10.times do |r|
      recipe = user.recipes.create!(
        hub: hub,
        title: "Recipe #{r.next} (u:#{u.next})",
        raw_content: Faker::Lorem.paragraphs(3)
      )
      recipe.update_attribute(:state, [:draft, :published].sample)
      puts "Recipe r:#{r.next} m:#{m.next} u:#{u.next} created"
    end
  end
end

# User
#   -> Role
#   -< Hubs:
#       pages (book)
#       posts (section)
#       blogs (month) -> callback
#       recipes (menus)
#       articles
#       notes
#       menus -< links
#   -< Comments
#   -< UploadedFiles


# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)

# book = {
#   'Program' => {
#     'Lexical Structure' => [
#       'Comments',
#       'Documentation',
#       'Whitespace',
#       'Literals',
#       'Identifiers'
#     ]
#   }
# }

# def create_hub user, title
#   obj          = user.send(:hubs).new
#   obj.title    = title
#   obj.hub_type = :book
#   obj.state    = :published
#   obj.save!
#   obj
# end

# def build_page_tree user, book, parent_obj = nil
#   book.each_pair do |key, value|
#     obj = create_hub(user, key)
#     obj.move_to_child_of(parent_obj) if parent_obj
#     parent_obj = obj

#     if value.is_a? Hash
#       build_page_tree(user, value, parent_obj)
#     end

#     if value.is_a? Array
#       value.each do |key|
#         obj = create_hub(user, key)
#         obj.move_to_child_of(parent_obj)
#       end
#     end

#   end
# end

# build_page_tree(User.first, book)

# Hub.roots.of_(:book).last.self_and_descendants

# User.destroy_all

# # cleanup
# Hub.destroy_all
# Post.destroy_all
# Blog.destroy_all
# Recipe.destroy_all
# Article.destroy_all

# puts 'cleanup done'

# russ = " Русский `^@#$&№%*«»!?.,:;{}()<>+|/~ тёст -- "

# (3..8).to_a.sample.times do |i|
#   name  = Faker::Name.name
#   login = name.downcase.gsub(/[\ \._]/, '-')
#   email = "#{login}@gmail.com"
  
#   # Users
#   user = User.new(
#     username: name,
#     login:    login + russ,
#     email:    email,
#     password: "password#{i.next}"
#   )
#   user.save!

#   if i == 0
#     hub          = user.hubs.new
#     hub.title    = "Ruby Book"
#     hub.state    = :published
#     hub.hub_type = :book
#     hub.save!

#     # book_contents
#   end

#   puts "=> User #{i} done"

#   Hub
#   (3..8).to_a.sample.times do |h|
#     hub_type = [:pages, :posts, :articles, :recipes, :blogs].sample

#     hub          = user.hubs.new
#     hub.title    = "Hub #{hub_type}  #{russ} (U:#{i.next} No:#{h.next})"
#     hub.state    = [:draft, :published, :deleted].sample
#     hub.hub_type = hub_type
#     hub.save!

#     puts "Hub #{h.next} done"

#     # create nested objects
#     (3..8).to_a.sample.times do |j|
#       obj       = hub.send(hub_type).new
#       obj.user  = user
#       obj.title = "#{hub_type}  #{russ} U:#{i.next} No:#{j.next}"
#       obj.state = [:draft, :published, :deleted].sample
#       obj.save!

#       puts "#{hub_type} U:#{i.next} No:#{j.next} - done!"
#       parent_obj = obj

#       puts "SUB CREATING"
#       (3..8).to_a.sample.times do |k|
#         obj       = hub.send(hub_type).new
#         obj.user  = user
#         obj.title = "#{hub_type}  #{russ} U:#{i.next} No:#{j.next}#{k.next}"
#         obj.state = [:draft, :published, :deleted].sample
#         obj.save!

#         obj.move_to_child_of(parent_obj)

#         puts "#{hub_type} U:#{i.next} No:#{j.next}#{k.next} - done!"
#       end

#     end
#   end
# end

# puts "Total User count: #{User.count}"
# puts "Total Post count: #{Page.count}"
# puts "Total Post count: #{Post.count}"
# puts "Total Blog count: #{Blog.count}"
# puts "Total Recipes count: #{Recipe.count}"
# puts "Total Article count: #{Article.count}"