class CreatePublications < ActiveRecord::Migration
  def change
    [:pages, :posts, :articles, :recipes, :blogs].each do |table_name|
      create_table table_name do |t|
        t.integer :user_id
        t.integer :hub_id
        
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

        # DateTime
        t.datetime :first_published_at
        t.timestamps
      end      
    end
  end
end