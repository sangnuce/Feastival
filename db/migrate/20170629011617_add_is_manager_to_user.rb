class AddIsManagerToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_manager, :boolean
  end
end
