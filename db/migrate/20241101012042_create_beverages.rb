class CreateBeverages < ActiveRecord::Migration[7.2]
  def change
    create_table :beverages do |t|
      t.string :name
      t.text :description
      t.boolean :is_alcholic
      t.integer :calories
      t.references :establishment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
