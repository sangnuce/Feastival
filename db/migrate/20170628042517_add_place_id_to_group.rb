class AddPlaceIdToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :place_id, :integer
  end
end
