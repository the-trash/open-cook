class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|
      t.integer :user_id

      t.string :title
      t.string :hub_type, default: :pages
      t.string :state

      t.string :legacy_url

      t.timestamps
    end
  end
end
