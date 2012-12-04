class CreateMolecules < ActiveRecord::Migration
  def change
    create_table :molecules do |t|
      t.string :name
      t.string :molecular_weight

      t.timestamps
    end
  end
end
