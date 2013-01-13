class NestedSetFields < ActiveRecord::Migration
  def change
    [:pages, :posts, :articles, :recipes, :blogs, :hubs].each do |table_name|
      change_table table_name do |t|
        t.integer :parent_id
        t.integer :lft
        t.integer :rgt
        t.integer :depth, default: 0
      end
    end
  end
end
