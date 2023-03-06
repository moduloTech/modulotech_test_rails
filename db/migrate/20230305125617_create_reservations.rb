class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references(:user, foreign_key: true, null: false)
      t.references(:room, foreign_key: true, null: false)
      t.date(:check_in, null: false)
      t.date(:check_out, null: false)

      t.timestamps
    end

    add_index(:reservations, %i[user_id room_id], unique: true)
  end
end
