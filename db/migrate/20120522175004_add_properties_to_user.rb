class AddPropertiesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :data_of_burn, :date
    add_column :users, :gender, :string
    add_column :users, :phone, :string
    add_column :users, :city, :string
    add_column :users, :about, :text

  end

  def self.down
    remove_column :users, :data_of_burn
    remove_column :users, :gender
    remove_column :users, :phone
    remove_column :users, :city
    remove_column :users, :about
  end
end
