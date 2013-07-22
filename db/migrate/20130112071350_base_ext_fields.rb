class BaseExtFields < ActiveRecord::Migration
  def change
    [:pages, :posts, :hubs].each do |table_name|
      change_table table_name do |t|
      
        # MAIN IMAGE | paperclip
        t.string   :main_image_file_name
        t.string   :main_image_content_type
        t.integer  :main_image_file_size, default: 0
        t.datetime :main_image_updated_at

        t.integer :show_count, default: 0
        t.string  :state, default: :draft # draft | published | deleted
        
        t.string  :moderation_state, default: :raw # raw | accepted | blocked
        t.text    :moderator_note
      end
    end
  end
end
