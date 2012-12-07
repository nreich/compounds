class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.integer :number
      t.date :date
      t.float :amount
      t.string :barcode
      t.float :initial_amount
      t.integer :salt
      t.decimal :formula_weight
      t.integer :molecule_id

      t.timestamps
    end
  end
end
