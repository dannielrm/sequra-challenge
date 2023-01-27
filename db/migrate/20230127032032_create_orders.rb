class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :merchant_id, foreign_key: true
      t.integer :shopper_id, foreign_key: true
      t.decimal :amount

      t.timestamps
      t.timestamp :completed_at
    end
    add_index :orders, :merchant_id
    add_index :orders, :shopper_id
  end
end
