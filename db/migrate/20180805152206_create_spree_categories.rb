class CreateSpreeCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_categories do |t|
      t.string :name
      t.integer :parent_id
      t.integer :soft_position
      t.timestamps
    end
  end
end
