class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|
      t.integer :user_id

      t.string :title
      t.string :hub_type
      t.string :state, default: :draft

      t.string :legacy_url

      t.timestamps
    end
  end
end
