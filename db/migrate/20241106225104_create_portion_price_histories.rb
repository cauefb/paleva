class CreatePortionPriceHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :portion_price_histories do |t|
      t.references :portion, foreign_key: true, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.date :date, null: false 

      t.timestamps
    end
  end
end
