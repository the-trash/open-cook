class ActAsFileStorage < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :total_files_count, default: 0
      t.integer :total_files_size,  default: 0
    end

    [:users, :pages, :posts, :articles, :recipes, :blogs, :notes, :hubs].each do |table_name|
      change_table table_name do |t|
        t.integer :files_count, default: 0
        t.integer :files_size,  default: 0
      end
    end
  end
end
