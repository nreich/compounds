class ChangeMolecularWeightToDecimalInMolecules < ActiveRecord::Migration
  def up
      change_column :molecules, :molecular_weight, :decimal, scale: 3
  end

  def down
      change_column :molcules, :molecular_weight, :string
  end
end
