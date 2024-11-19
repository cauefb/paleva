class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.references :establishment, null: false, foreign_key: true
      t.string :email, null: false
      t.string :cpf, null: false
      
      t.boolean :used, default: false


      t.timestamps
    end
  end
end
