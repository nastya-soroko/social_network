class Micropost < ActiveRecord::Base
  attr_accessible :content, :from_id, :user_id
  belongs_to :user
  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id,:from_id, :presence => true
  default_scope :order => 'microposts.created_at DESC'
end
