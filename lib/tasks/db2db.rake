CONNECTION_PARAMS = {
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "qwerty",
  :database => "open_cook_dev",
  :encoding => "utf8"
}

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
  has_many :comments
end

namespace :db do
  namespace :to do

    # rake db:to:db
    task db: :environment do
      # Rake::Task["rake db:bootstrap"].invoke
      # Rake::Task["db:first:user"].invoke
      
      root     = User.root

      recipe   = OldRecipe.first
      comments = OldComments.where(object_id: recipe.id, object_type: :Recipe)
      files    = OldFiles.where(storage_id: recipe.id, storage_type: :Recipe)

      comment = comments.first

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