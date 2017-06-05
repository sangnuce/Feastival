class FixGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :status, :integer, default: 0
  end
end
