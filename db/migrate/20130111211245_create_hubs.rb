class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|
      t.strig  :title
      t.string :hub_type
      t.string :state

      t.timestamps
    end
  end
end
