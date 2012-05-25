class RemoveColumnGender < ActiveRecord::Migration
  def up
		remove_column :users ,:gender
  end


end
