class ChangeTypeColumnPostsContent < ActiveRecord::Migration
  def change
  	change_column :posts, :raw_content, :text, limit: 4294967295
  	change_column :posts, :content, :text, limit: 4294967295
  end
end
