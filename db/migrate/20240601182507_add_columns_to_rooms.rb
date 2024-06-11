class AddColumnsToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :name, :string
    add_column :rooms, :location, :string
    add_column :rooms, :capacity, :integer
    add_reference :rooms, :user, null: false, foreign_key: true
    add_monetize :rooms, :price_per_night,
                 amount: { null: false, default: 0 },
                 currency: { null: false, default: 'EUR' }
  end
end
