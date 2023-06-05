class ChangePriceOnRooms < ActiveRecord::Migration[7.0]
  def change
    remove_column :rooms, :price
    add_monetize :rooms, :price
  end
end
