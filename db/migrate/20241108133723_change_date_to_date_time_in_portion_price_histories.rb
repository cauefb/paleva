class ChangeDateToDateTimeInPortionPriceHistories < ActiveRecord::Migration[7.2]
  def change
    change_column :portion_price_histories, :date, :datetime
  end
end
