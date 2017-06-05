class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user
      t.text :content
      t.string :notifiable_type
      t.integer :notifiable_id

      t.timestamps
    end
  end
end
