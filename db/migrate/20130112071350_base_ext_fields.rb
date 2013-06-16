class BaseExtFields < ActiveRecord::Migration
  def change
    [:pages, :posts, :hubs].each do |table_name|
      change_table table_name do |t|
        t.string  :main_image_url

        t.integer :show_count, default: 0
        
        t.string  :state, default: :draft # draft | published | deleted
        
        t.string  :moderation_state, default: :raw # raw | accepted | blocked
        t.text    :moderator_note
      end
    end
  end
end
