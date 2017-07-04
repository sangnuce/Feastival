class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :title
      t.text :address
      t.float :longitude
      t.float :latitude
      t.string :website
      t.text :description
      t.integer :category_id
      t.integer :manager_id
      t.boolean :is_approved, default: false
      t.string :phonenumber

      t.timestamps
    end
  end
end
