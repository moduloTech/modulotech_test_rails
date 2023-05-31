class AddFieldsToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :name, :string
    add_column :rooms, :location, :string
    add_column :rooms, :price, :integer

    add_index :rooms, :name
    add_index :rooms, :location
  end
end
