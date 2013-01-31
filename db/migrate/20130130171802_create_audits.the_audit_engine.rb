# This migration comes from the_audit_engine (originally 20130130163149)
class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.integer :user_id

      t.string :obj_id
      t.string :obj_type

      t.string :controller_name
      t.string :action_name

      t.string :ip
      t.string :remote_ip
      t.string :fullpath
      t.string :referer
      t.string :user_agent
      t.string :remote_addr
      t.string :remote_host

      t.text :data

      # add_index :the_audits, :referer
      # add_index :the_audits, :user_agent
      # add_index :the_audits, [:controller_name, :action_name]

      t.timestamps
    end
  end
end
