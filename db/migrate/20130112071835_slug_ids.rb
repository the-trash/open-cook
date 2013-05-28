class SlugIds < ActiveRecord::Migration
  def change
    [:pages, :posts, :hubs].each do |table_name|
      change_table table_name do |t|
        t.string  :slug
        t.string  :short_id
        t.string  :friendly_id
      end
    end
  end
end
