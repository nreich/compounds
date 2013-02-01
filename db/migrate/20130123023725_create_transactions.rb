class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :batch_id
      t.decimal :amount, scale: 1

      t.timestamps
    end
  end
end
