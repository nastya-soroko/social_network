class Request < ActiveRecord::Base
  attr_accessible :user_from_id,:user_id
  belongs_to :user_from, :class_name => "User"
  belongs_to :user, :class_name => "User"
  validates :user_id,:user_from_id, :presence => true
end

