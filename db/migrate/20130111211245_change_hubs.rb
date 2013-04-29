class ChangeHubs < ActiveRecord::Migration
  def change
    change_table :hubs do |t|
      t.string  :hub_type

      t.integer :draft_count,     default: 0
      t.integer :published_count, default: 0
      t.integer :deleted_count,   default: 0
    end
  end
end
