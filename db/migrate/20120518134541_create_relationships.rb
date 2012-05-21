class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :user_friend_id
      t.integer :friend_id

      t.timestamps
    end
    add_index :relationships, :user_friend_id
    add_index :relationships, :friend_id
    add_index :relationships, [:user_friend_id, :friend_id], :unique => true
  end

  def self.down
    drop_table :relationships
  end
end
