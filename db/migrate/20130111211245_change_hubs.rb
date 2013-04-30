class ChangeHubs < ActiveRecord::Migration
  def change
    change_table :hubs do |t|
      t.string  :hub_type

      t.integer :draft_publications_count,     default: 0
      t.integer :published_publications_count, default: 0
      t.integer :deleted_publications_count,   default: 0
    end
  end
end
