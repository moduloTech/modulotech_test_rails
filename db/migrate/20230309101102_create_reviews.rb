class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :rating
      t.integer :review_type
      t.references :writer, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
