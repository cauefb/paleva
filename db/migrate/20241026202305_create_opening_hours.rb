class CreateOpeningHours < ActiveRecord::Migration[7.2]
  def change
    create_table :opening_hours do |t|
      t.references :establishment, null: false, foreign_key: true
      t.string :day_of_week
      t.time :open_time
      t.time :close_time
      t.boolean :closed

      t.timestamps
    end
  end
end
