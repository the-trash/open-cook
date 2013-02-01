class SlugIds < ActiveRecord::Migration
  def change
    [:pages, :posts, :articles, :recipes, :blogs, :hubs].each do |table_name|
      change_table table_name do |t|
        t.string  :short_id
        t.string  :friendly_id
      end
    end
  end
end
