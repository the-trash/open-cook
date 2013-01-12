class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :user_id

      # Base
      t.string  :title

      # Ext
      t.string  :main_image_url
      t.integer :show_count, default: 0
      t.string  :state,      default: :draft

      t.timestamps
    end
  end
end
