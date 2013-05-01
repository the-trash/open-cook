# This migration comes from the_storages_engine (originally 20130101010101)
class AttachedFiles < ActiveRecord::Migration
  def change
    create_table :attached_files do |t|
      t.integer :user_id
      t.references :storage, polymorphic: true

      t.string :title, null: false
      t.string :state, default: :active

      # paperclip
      t.string   :attachment_file_name
      t.string   :attachment_content_type
      t.integer  :attachment_file_size, default: 0
      t.datetime :attachment_updated_at

      # nested set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth, default: 0

      t.timestamps
    end
  end
end
