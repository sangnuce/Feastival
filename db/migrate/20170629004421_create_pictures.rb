class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :image
      t.string :imageable_type
      t.integer :imageable_id
      t.timestamps
    end
  end
end
