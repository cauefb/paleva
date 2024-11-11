class CreateJoinTableMenusBeverages < ActiveRecord::Migration[7.2]
  def change
    create_join_table :menus, :beverages do |t|
      t.index [:menu_id, :beverage_id], unique: true
      t.index [:beverage_id, :menu_id]
    end
  end
end
