class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.integer :place_id
      t.text :description

      t.timestamps
    end
  end
end
