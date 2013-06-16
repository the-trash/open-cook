class ChangeHubs < ActiveRecord::Migration
  def change
    change_table :hubs do |t|
      t.integer :pubs_count_draft,     default: 0
      t.integer :pubs_count_published, default: 0
      t.integer :pubs_count_deleted,   default: 0
    end
  end
end
