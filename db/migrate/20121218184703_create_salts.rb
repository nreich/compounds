class CreateSalts < ActiveRecord::Migration
  def change
    create_table :salts do |t|
      t.string :name

      t.timestamps
    end
  end
end
