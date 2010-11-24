class CreateProjectdetails < ActiveRecord::Migration
  def self.up
    create_table :projectdetails do |t|
      t.date :month
      t.float :OriginalBaselinePlan
      t.float :LreSite
      t.float :LrePmc
      t.float :Ac
      t.float :PercentageProgress
      t.integer :InternalIssues
      t.integer :ExternalIssues
      t.integer    :projid, :unique => false

      t.timestamps
    end
  end

  def self.down
    drop_table :projectdetails
  end
end
