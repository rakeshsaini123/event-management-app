class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.integer :ticket_type, default: 0
      t.float :price
      t.boolean :availability, default: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
