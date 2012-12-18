class ChangeColumnSaltToSaltIdInBatches < ActiveRecord::Migration
  def up
      rename_column :batches, :salt, :salt_id
  end

  def down
      rname_column :batches, :salt_id, :salt
  end
end
