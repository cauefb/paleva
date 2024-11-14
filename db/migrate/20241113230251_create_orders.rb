class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :menu, null: false, foreign_key: true
      t.string :code
      t.string :costumer_name
      t.string :costumer_phone
      t.string :costumer_email
      t.string :costumer_doc
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end
