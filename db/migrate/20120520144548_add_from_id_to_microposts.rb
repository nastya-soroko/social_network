class AddFromIdToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :from_id, :integer
    add_index :microposts,  :from_id
  end

  def self.down
    remove_column :microposts, :from_id
  end


end
