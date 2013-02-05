class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|
      t.integer :user_id

      t.string :title
      t.string :hub_type

      t.integer :show_count, default: 0

      t.string :state,            default: :draft       # draft | published
      t.string :moderation_state, default: :unmoderated # unmoderated | moderated | blocked

      t.string :legacy_url

      t.timestamps
    end
  end
end
