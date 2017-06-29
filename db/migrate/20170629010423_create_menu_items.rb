class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.integer :menu_id
      t.string :name
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end
