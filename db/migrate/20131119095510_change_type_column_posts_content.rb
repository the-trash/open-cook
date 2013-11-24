class ChangeTypeColumnPostsContent < ActiveRecord::Migration
  def change
    # 1 to 255 bytes: TINYTEXT
    # 256 to 65535 bytes: TEXT
    # 65536 to 16777215 bytes: MEDIUMTEXT
    # 16777216 to 4294967295 bytes: LONGTEXT
  	change_column :posts, :raw_content, :text, limit: 16777215
  	change_column :posts, :content,     :text, limit: 16777215
  end
end
