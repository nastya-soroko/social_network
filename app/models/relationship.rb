class Relationship < ActiveRecord::Base
  attr_accessible :friend_id
  belongs_to :user_friend, :class_name => "User"
  belongs_to :friend, :class_name => "User"
  validates :user_friend_id, :presence => true
  validates :friend_id, :presence => true
end
