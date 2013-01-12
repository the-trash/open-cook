class SlugIds < ActiveRecord::Migration
  def change
    [:posts, :aricles, :recipes, :blogs, :menus].each do |table_name|
      change_table table_name do |t|
        t.string  :short_id
        t.string  :slug_id
        t.string  :friendly_id
      end
    end
  end
end
