class AddResolvedToReport < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :resolved, :boolean, default: false
  end
end
