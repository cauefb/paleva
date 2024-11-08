class ChangePriceToIntegerInPortionPriceHistories < ActiveRecord::Migration[7.2]
  def change
    change_column :portion_price_histories, :price, :integer, null: false
  end
end
