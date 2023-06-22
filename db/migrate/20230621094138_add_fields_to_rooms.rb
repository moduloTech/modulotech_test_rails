class AddFieldsToRooms < ActiveRecord::Migration[7.0]
  def change
    change_table(:rooms) do |t|
      t.string :name, :address, null: false
      t.decimal :longitude, :latitude
      t.references :user, index: true
      t.monetize :price_per_night
    end
  end
end
