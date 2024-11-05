class AddActiveToBeverages < ActiveRecord::Migration[7.2]
  def change
    add_column :beverages, :active, :boolean, default: true
  end
end
