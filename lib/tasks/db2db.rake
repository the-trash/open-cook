# encoding: UTF-8

CONNECTION_PARAMS = {
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "qwerty",
  :database => "open_cook_dev",
  :encoding => "utf8"
}

# OLD DataBase
class OldFiles < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS
  self.table_name = :uploaded_files
end

class OldComments < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS
  self.table_name = :comments
end

class OldRecipe < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS
  self.table_name = :recipes
end

class OldMenu < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS
  self.table_name = :menus
end

# Helpers
def create_system_hub slug, title, type
  User.root.hubs.where(title: title).first_or_create!(
    slug:  slug,
    title: title,
    pubs_type: type,
    state: :published
  )
end

def create_hub_for_recipes menu, parent_hub
  hub = Hub.where(title: menu.title).first_or_create!(
    user: User.root,
    title: menu.title,
    pubs_type: :posts,
    state: menu.state
  )
  hub.move_to_child_of(parent_hub) if parent_hub
  hub
end

namespace :db do
  namespace :to do

    # rake db:to:db
    task db: :environment do
      # Rake::Task["rake db:bootstrap"].invoke
      Rake::Task["db:first:user"].invoke
      
      root        = User.root
      recipes_hub = create_system_hub(:recipes, 'Рецепты', :posts)

      OldRecipe.all.each do |recipe|
        menu     = OldMenu.find(recipe.menu_id)
        comments = OldComments.where(object_id: recipe.id, object_type: :Recipe)
        files    = OldFiles.where(storage_id: recipe.id, storage_type: :Recipe)

        recipe_hub = create_hub_for_recipes(menu, recipes_hub)

        recipe_hub.pubs.where(title: recipe.title).first_or_create!(
          user:            root,
          title:           recipe.title,
          raw_intro:       recipe.textile_annotation,
          raw_content:     recipe.textile_content,
          state:           recipe.state
        )
        print '.'

        # 

        # p recipe.friendly_url
        # p recipe.title
        # p recipe.textile_content
        # p recipe.html_content
        # p recipe.state
        # p recipe.show_count
        # p recipe.tags_inline

        # Recipe.new(
        # )

        # p recipe.title
        # p recipe.tags_inline
        # p files.count
        # p comments.count
        # p '#'*20
      end

      p "Hub count"
      p Hub.count
      p "Post count"
      p Post.count

      # recipe   = OldRecipe.first
      # comments = OldComments.where(object_id: recipe.id, object_type: :Recipe)
      # files    = OldFiles.where(storage_id: recipe.id, storage_type: :Recipe)

      # p comment.object_title
      # p comment.object_friendly_url
      # p comment.user_login
      # p comment.title
      # p comment.textile_content
      # p comment.state
      # p comment.created_at
      # p comment.updated_at

      # file = files.first
      # p file.file_file_name
      # p file.file_content_type
      # p file.file_file_size
      # p file.file_updated_at
      # p file.created_at
      # p file.updated_at

      # t.integer :
      # t.string  :

      # p recipe.friendly_url
      # p recipe.title
      # p recipe.textile_content
      # p recipe.html_content
      # p recipe.state
      # p recipe.show_count
      # p recipe.tags_inline
    end

  end
end