class AddVideoToMicropost < ActiveRecord::Migration
	def self.up
		change_table :microposts do |t|
			t.has_attached_file :video
		end
	end

	def self.down
		drop_attached_file :microposts, :video
	end
end
