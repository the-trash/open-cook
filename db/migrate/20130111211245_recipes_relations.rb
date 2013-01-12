class RecipesRelations < ActiveRecord::Migration
  def change
    change_table :recipes do |t|
      t.integer :menu_id
    end
  end
end
