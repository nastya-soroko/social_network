class AddImageToMicropost < ActiveRecord::Migration
	def self.up
		change_table :microposts do |t|
			t.has_attached_file :photo
		end
	end

	def self.down
		drop_attached_file :microposts, :photo
	end
end
