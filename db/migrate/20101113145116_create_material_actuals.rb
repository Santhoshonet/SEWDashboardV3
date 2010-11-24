class CreateMaterialActuals < ActiveRecord::Migration
  def self.up
    create_table :material_actuals do |t|
      t.string :name
      t.string :unit
      t.float :availableqty
      t.float :consumptionqty
      t.integer :projid, :unique => false
      t.timestamps
    end
  end

  def self.down
    drop_table :material_actuals
  end
end
