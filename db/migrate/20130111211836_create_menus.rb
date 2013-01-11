class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :user_id
      
      # ID's
      t.string  :short_id
      t.string  :slug_id
      t.string  :friendly_id

      # Base
      t.string  :title

      # Ext
      t.string  :main_image_url
      t.integer :show_count, default: 0
      t.string  :state,      default: :draft

      # nested_set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth, default: 0

      t.timestamps
    end
  end
end
