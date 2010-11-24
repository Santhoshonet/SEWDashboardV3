class CreateMaterials < ActiveRecord::Migration
  def self.up
    create_table :materials do |t|
      t.text :assetnumber
      t.text :description
      t.text :capacity
      t.float :ifc
      t.float :scheduledhour
      t.float :unavailablehour
      t.float :utilizedhours
      t.float :theoreticaloutput
      t.float :actualoutput
      t.float :theoreticalconsumption
      t.float :actualconsumption
      t.integer    :projid, :unique => false
      t.timestamps
    end
  end

  def self.down
    drop_table :materials
  end
end
