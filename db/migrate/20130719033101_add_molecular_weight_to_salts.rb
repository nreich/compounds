class AddMolecularWeightToSalts < ActiveRecord::Migration
  def change
    add_column :salts, :molecular_weight, :float
  end
end
