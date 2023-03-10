class AddColumnsToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :title, :string
    add_column :rooms, :description, :text
    add_column :rooms, :price, :float
    add_column :rooms, :room_type, :integer
    add_column :rooms, :address, :string
    add_column :rooms, :city, :string
    add_column :rooms, :country, :string
    add_reference :rooms, :user, null: false, foreign_key: true
  end
end
