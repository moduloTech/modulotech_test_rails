class AddNamePriceToRooms < ActiveRecord::Migration[7.0]
  def change
    add_reference :rooms, :user, foreign_key: true
    add_column :rooms, :name, :string
    add_column :rooms, :price, :integer
  end
end
