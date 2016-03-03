class CreateActiveJobLocks < ActiveRecord::Migration

  def self.up
    create_table :locks do |t|
      t.string :name, :limit => 40
      t.timestamps
    end
    add_index :locks, :name, :unique => true
  end

  def self.down
    remove_index :locks, :column => :name
    drop_table :locks
  end

end
