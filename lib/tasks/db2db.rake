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

class OldTagRelation < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS
  self.table_name = :taggings
end

class OldTag < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS
  self.table_name = :tags
end

# ActsAsTaggableOn::Tagging.where(taggable_id: 39, taggable_type: :Post).count

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

def set_tags_on item, type = :Post
  rels     = OldTagRelation.where(taggable_id: item.id, taggable_type: type, context: :tags)
  tag_ids  = rels.pluck(:tag_id)
  tag_list = OldTag.where(id: tag_ids).pluck(:name).join(', ')

  if !tag_list.blank?
    p "==> #{tag_list}"
    item.tag_list = tag_list
    item.save!
  end

  # contexts = OldTagRelation.pluck(:context).uniq
  # contexts.each do |context|; end
end

def set_comments_for item, type = :Post
  comments = OldComments.where(object_id: item.id, object_type: type)

  comments.each do |comment|
    item.comments.create!(
      title: comment.title,
      contacts: comment.contacts,
      raw_content: comment.textile_content,
      state: :published
    )
    print 'c'
  end
  puts
end

namespace :db do
  namespace :to do

    # rake db:to:db
    task db: :environment do
      Rake::Task["db:bootstrap"].invoke
      Rake::Task["db:first:user"].invoke

      root        = User.root
      recipes_hub = create_system_hub(:recipes, 'Рецепты', :posts)

      OldRecipe.all.each do |recipe|
        menu     = OldMenu.find(recipe.menu_id)
        comments = OldComments.where(object_id: recipe.id, object_type: :Recipe)
        files    = OldFiles.where(storage_id: recipe.id, storage_type: :Recipe)

        recipe_hub = create_hub_for_recipes(menu, recipes_hub)

        recipe = recipe_hub.pubs.where(title: recipe.title).first_or_create!(
          user:            root,
          title:           recipe.title,
          raw_intro:       recipe.textile_annotation,
          raw_content:     recipe.textile_content,
          state:           recipe.state
        )

        set_tags_on(recipe, :Recipe)
        set_comments_for(recipe, :Recipe)

        print '.'
      end
    end
  end
end