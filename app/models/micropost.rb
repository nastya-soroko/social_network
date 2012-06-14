class Micropost < ActiveRecord::Base
  attr_accessible :content, :from_id, :user_id ,:photo,:video
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :video
  belongs_to :user
  validates :content, :length => { :maximum => 140 }
  validates :user_id,:from_id, :presence => true
  default_scope :order => 'microposts.created_at DESC'

  def has_nonempty_content?
  	 content.gsub(/[ ]*/,"")!=""||photo.original_filename||video_file_name
  end

end
