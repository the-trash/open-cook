# This migration comes from the_storages_engine (originally 20130101010101)
class UploadedFiles < ActiveRecord::Migration
  def change
    create_table :uploaded_files do |t|
      t.integer :user_id
      t.references :storage, polymorphic: true

      t.string :title, null: false
      t.string :state, default: :active

      # paperclip
      t.string   :file_file_name
      t.string   :file_content_type
      t.integer  :file_file_size, default: 0
      t.datetime :file_updated_at

      # nested set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth, default: 0

      t.timestamps
    end
  end
end
