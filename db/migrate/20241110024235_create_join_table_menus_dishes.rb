class CreateJoinTableMenusDishes < ActiveRecord::Migration[7.2]
  def change
    create_join_table :menus, :dishes do |t|
      t.index [:menu_id, :dish_id], unique: true
      t.index [:dish_id, :menu_id]
    end
  end
end
