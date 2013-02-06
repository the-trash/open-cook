class ChangeHubs < ActiveRecord::Migration
  def change
    change_table :hubs do |t|
      t.string  :hub_type
    end
  end
end
