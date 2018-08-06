class CreateSpreeItems < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_items do |t|
      t.string :name
      t.attachment :image
      t.references :category
      t.timestamps
    end
  end
end
