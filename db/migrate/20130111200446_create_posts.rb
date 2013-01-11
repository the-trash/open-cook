class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id

      # ID's
      t.string  :short_id
      t.string  :slug_id
      t.string  :friendly_id
      
      # Meta
      t.string :author
      t.string :keywords
      t.string :description
      t.string :copyright
      
      # Base
      t.string :title
      t.text   :raw_intro
      t.text   :raw_content

      t.text   :intro
      t.text   :content

      # Ext
      t.string  :main_image_url
      t.integer :show_count, default: 0
      t.string  :state,      default: :draft

      # nested_set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth, default: 0

      # act as file storage
      t.integer :files_count, default: 0
      t.integer :files_size,  default: 0

      # DateTime
      t.datetime :first_published_at
      t.timestamps
    end
  end
end
