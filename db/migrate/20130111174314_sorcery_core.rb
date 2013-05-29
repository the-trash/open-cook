class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login,            :null => false
      t.string :username,         :default => nil   # if you use another field as a username, for example email, you can safely remove this field.
      t.string :email,            :default => nil   # if you use this field as a username, you might want to make it :null => false.
      t.string :open_password,    :default => nil
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil

      # the_role
      t.integer :role_id,    default: nil
      t.integer :show_count, default: 0
      t.string  :state,      default: :active # active | banned

      # cache_counters => published
      t.integer :hubs_count,  default: 0
      t.integer :posts_count, default: 0

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end