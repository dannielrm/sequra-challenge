class CreateDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursements do |t|
      t.integer :order_id, foreign_key: true
      t.decimal :amount
      t.timestamp :processed_at

      t.timestamps
    end
    add_index :disbursements, :order_id
  end
end
