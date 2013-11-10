class ChangeHubs < ActiveRecord::Migration
  def change
    change_table :hubs do |t|
      t.string  :pubs_type, default: :posts
      t.boolean :optgroup,  default: false

      t.integer :pubs_draft_count,     default: 0
      t.integer :pubs_published_count, default: 0
      t.integer :pubs_deleted_count,   default: 0
    end
  end
end
