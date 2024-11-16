class AddEstablishmentToOrders < ActiveRecord::Migration[7.2]
  def change
    add_reference :orders, :establishment, null: false, foreign_key: true
  end
end
