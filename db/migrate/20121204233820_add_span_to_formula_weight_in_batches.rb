class AddSpanToFormulaWeightInBatches < ActiveRecord::Migration
    def up
        change_column :batches, :formula_weight, :decimal, scale: 3
    end

    def down
        change_column :batches, :formula_weight, :decimal
    end
end
