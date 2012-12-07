class RenameNumberToLotNumberInBatches < ActiveRecord::Migration
  def up
      rename_column :batches, :number, :lot_number
  end

  def down
      rename_column :batches, :number, :lot_number
  end
end
