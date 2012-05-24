class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.integer :user_id
      t.integer :user_from_id

      t.timestamps
    end
    add_index :requests, :user_id
    add_index :requests, :user_from_id
    add_index :requests, [:user_id, :user_from_id], :unique => true
  end
  def self.down
    drop_table :requests
  end

end


