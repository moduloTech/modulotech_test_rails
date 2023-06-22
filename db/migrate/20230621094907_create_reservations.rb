class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.datetime :check_in, null: false
      t.datetime :check_out, null: false
      t.string :status

      t.belongs_to :user, index: true
      t.belongs_to :room, index: true

      t.timestamps
    end
  end
end
