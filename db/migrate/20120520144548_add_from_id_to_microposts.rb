class AddFromIdToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :from_id, :integer

  end

  def self.down
    remove_column :microposts, :from_id
  end
end
