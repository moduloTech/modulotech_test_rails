class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :street
      t.belongs_to :room

      t.timestamps
    end
  end
end
