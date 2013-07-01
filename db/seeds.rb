# encoding: UTF-8
User.destroy_all
Role.destroy_all

Hub.destroy_all
Post.destroy_all
Comment.destroy_all

#######################################################
# Create Roles
#######################################################

  # Admin
  admin_role = Role.create!(
    name: :admin,
    title: "Admin Role",
    description: "Role for admin"
  )
  admin_role.create_rule(:system, :administrator)
  admin_role.rule_on(:system, :administrator)
  
  # Author
  author_role = Role.create!(
    name: :author,
    title: "Author role",
    description: "Authors"
  )

  author_role.update_role(
    users:  {
      cabinet: true
    },
    posts: {
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      rebuild: true,
      destroy: true
    },
    forums: {
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      rebuild: true,
      destroy: true
    },
    topics: {
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      rebuild: true,
      destroy: true
    }
  )

  # User
  user_role = Role.create!(
    name: :user,
    title: "User",
    description: "Users"
  )

  user_role.update_role(
    users:  {
      cabinet: true
    },
    forums: {
      index:   true,
      show:    true
    },
    topics: {
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      rebuild: true,
      destroy: true
    }
  )

puts "Roles created"

######################################################
# Create Users
######################################################
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
  # with different roles
  role_name = [:user, :user, :author].sample
  user.update_attributes(role: Role.with_name(role_name))

  puts "User #{i.next} role:#{role_name} created"
end

# set Admin
# update with validations
User.first.update_attributes(role: Role.with_name(:admin))
puts "Admin set"

#####################################
# HUBS
#####################################
def create_system_hub name
  User.root.hubs.create!(
    title:    name,
    pub_type: :system_hubs
  )
end
#####################################
# System HUBS
#####################################
create_system_hub(:articles)
create_system_hub(:recipes)
create_system_hub(:videos)
create_system_hub(:blogs)

User.root.hubs.create!(
  title:    :pages,
  pub_type: :pages
)

#####################################
# Recipes HUBS
#####################################
puts 'Recipe HUBS'

recipes_hub = Hub.with_title(:recipes)

[
  "Блины",
  "Интервью",
  "Статьи",
  "Детские рецепты Марии Панковой",
  "Открытая кухня Ольги Космос",
  "Заготовки",
  "Супы",
  "На второе",
  "Салаты",
  "Рыба",
  "Гарниры",
  "Овощи",
  "Вкусняшки к чаю",
  "Кухня мужика",
  "Напитки",
  "Птица с подворья",
  "К завтраку",
  "Закуски",
  "Ликеры и Сиропы",
  "Выпечка несладкая",
  "Соусы, дипы",
  "Десерты",
  "Кремы"
].each do |title|
  hub = User.root.hubs.create!(title: title, pub_type: :recipes)
  hub.to_published
  hub.move_to_child_of(recipes_hub)
  print '.'
end

puts

#####################################
# Blogs Videos Articles
#####################################

%w[ blogs videos articles ].each do |name|
  puts " --- #{name}"

  15.times do
    user     = User.all.sample
    holder_hub = Hub.with_title(name)

    10.times do
      post = user.posts.create!(
        hub: holder_hub,
        pub_type: name,
        title: "#{name}: " + Faker::Lorem.sentence,
        raw_intro: Faker::Lorem.paragraphs(2).join,
        raw_content: Faker::Lorem.paragraphs(3).join
      )
      post.send("to_#{ %w[draft published deleted].sample }")
      print '.'
    end
  end

  puts
end

#####################################
# Recipes
#####################################

puts " --- recipes"

recipes_hub = Hub.with_title(:recipes)
recipes_hub.children.each do |menu|
  5.times do
    user = User.all.sample

    5.times do
      post = user.posts.create!(
        hub: menu,
        pub_type: :recipes,
        title: "#{menu.title}: " + Faker::Lorem.sentence,
        raw_intro: Faker::Lorem.paragraphs(2).join,
        raw_content: Faker::Lorem.paragraphs(3).join
      )
      post.send("to_#{ %w[draft published deleted].sample }")
      print '.'
    end
  end
end

#####################################
# Pages
#####################################

puts " --- pages"

root      = User.root
pages_hub = Hub.with_title(:pages)

top_pages = root.hubs.create!(
  title:    :top_pages,
  pub_type: :pages
)
bottom_pages = root.hubs.create!(
  title:    :bottom_pages,
  pub_type: :pages
)

top_pages.move_to_child_of    pages_hub
bottom_pages.move_to_child_of pages_hub

#-----------------------------------
# Top
#-----------------------------------
root.pages.create!(
  hub: top_pages,
  title: :about,
  raw_content: Faker::Lorem.paragraphs(2).join,
  state: :published
)
root.pages.create!(
  hub: top_pages,
  title: :authors,
  raw_content: Faker::Lorem.paragraphs(2).join,
  state: :published
)
root.pages.create!(
  hub: top_pages,
  title: :rules,
  raw_content: Faker::Lorem.paragraphs(2).join,
  state: :published
)
#-----------------------------------
# Bottom
#-----------------------------------
root.pages.create!(
  hub: bottom_pages,
  title: :advertising,
  raw_content: Faker::Lorem.paragraphs(2).join,
  state: :published
)
root.pages.create!(
  hub: bottom_pages,
  title: :for_authors,
  raw_content: Faker::Lorem.paragraphs(2).join,
  state: :published
)
root.pages.create!(
  hub: bottom_pages,
  title: :contacts,
  raw_content: Faker::Lorem.paragraphs(2).join,
  state: :published
)

# def create_comment post, parent_comment = nil
#   owner = [User.all.sample, nil].sample

#   comment = post.comments.create!(
#     user:        owner,
#     commentable: post,
#     title:       Faker::Lorem.sentence,
#     contacts:    Faker::Lorem.sentence,
#     raw_content: Faker::Lorem.paragraphs(4).join,
#     parent_id:   parent_comment.try(:id)
#   )

#   puts "Comment created #{parent_comment.try(:id)}"
#   puts "Default Comment state => #{comment.state}"

#   st = [:draft, :published].sample
#   puts "to => #{st}"
#   comment.send("to_#{st}")

#   comment
# end

# Post.all.each do |post|
#   3.times do
#     parent = create_comment(post)
#     3.times do
#       parent = create_comment(post, parent)
#       3.times do
#         create_comment(post, parent)
#       end
#     end
#   end
# end


# Comment.all.shuffle[0..40].each do |comment|
#   comment.to_deleted
#   puts "C: #{comment.id} => to deleted"
# end

######################################################
# Info fn
######################################################
def hub_info(type)
  puts "Hub of #{type} count: #{Hub.of_(type).count}"
  puts "Hub of #{type} published count: #{Hub.of_(type).with_state(:published).count}"
  puts "Hub of #{type} draft count: #{Hub.of_(type).with_state(:draft).count}"
  puts "~" * 20
end

def model_info model
  puts "#{model} count: #{model.count}"
  puts "#{model} published count: #{model.with_state(:published).count}"
  puts "#{model} draft count: #{model.with_state(:draft).count}"
  puts "#{model} deleted count: #{model.with_state(:deleted).count}"
  puts "~" * 20
end
######################################################
# Create data for authors
######################################################
_num = 20
puts "~" * _num

puts "Total User count: #{User.count}"
puts "~" * _num

puts "Admins count: #{User.with_role(:admin).count}"
puts "Authors count: #{User.with_role(:author).count}"
puts "Users count: #{User.with_role(:user).count}"
puts "~" * _num

puts "Hubs count: #{Hub.count}"
puts "~" * _num

hub_info(:pages)
model_info(Page)

hub_info(:posts)
model_info(Post)

model_info(Comment)