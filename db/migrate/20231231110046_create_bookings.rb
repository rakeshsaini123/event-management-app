class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.float :final_amount
      t.integer :ticket_count
      t.references :customer, null: false, foreign_key: { to_table: :users }
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
