class AddItemNameAndUnitPriceToOrderItems < ActiveRecord::Migration[7.2]
  def change
    add_column :order_items, :item_name, :string
    add_column :order_items, :unit_price, :integer
  end
end
