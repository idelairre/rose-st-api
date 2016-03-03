class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :amount
      t.string :transaction_type
      t.string :charge_id
      t.timestamps null: false
    end
  end
end
