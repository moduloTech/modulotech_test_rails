class AddFieldsToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column(:rooms, :name, :string)
    add_column(:rooms, :location, :string)
    add_column(:rooms, :price_per_night, :decimal)

    add_column(:rooms, :start_date, :date)
    add_column(:rooms, :end_date, :date)

    add_reference(:rooms, :user, foreign_key: true)
  end
end
