class ChangeHubs < ActiveRecord::Migration
  def change
    change_table :hubs do |t|
      t.string  :hub_type

      t.integer :draft_children_count,     default: 0
      t.integer :published_children_count, default: 0
      t.integer :deleted_children_count,   default: 0
    end
  end
end
