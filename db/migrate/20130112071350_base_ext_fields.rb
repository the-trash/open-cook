class BaseExtFields < ActiveRecord::Migration
  def change
    [:pages, :posts, :articles, :recipes, :blogs, :notes, :hubs].each do |table_name|
      change_table table_name do |t|
        t.string  :main_image_url

        t.integer :show_count, default: 0
        
        t.string  :state,            default: :draft       # draft | published
        t.string  :moderation_state, default: :unmoderated # unmoderated | moderated | blocked
        t.text    :moderator_note
      end
    end
  end
end
