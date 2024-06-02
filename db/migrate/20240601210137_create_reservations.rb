class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.string :status, default: "pending"
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.monetize :price
      
      t.timestamps
    end
  end
end
