class CreatePortions < ActiveRecord::Migration[7.2]
  def change
    create_table :portions do |t|
      t.string :description, null: false
      t.integer :price, precision: 10, scale: 2, null: false
      t.references :dish, null: false, foreign_key: true
      t.references :beverage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
