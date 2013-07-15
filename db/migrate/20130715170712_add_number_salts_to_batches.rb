class AddNumberSaltsToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :number_salts, :integer
  end
end
