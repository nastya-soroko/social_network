require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :data_of_burn, :sex,
                  :phone, :city,:about ,:status,:admin, :blocked

  has_many :microposts, :dependent => :destroy
  has_many :relationships, :foreign_key => "user_friend_id",
           :dependent => :destroy
  has_many :friends, :through => :relationships
  has_many :requests,:foreign_key=>"user_id",
           :dependent =>:destroy
  has_many :senders, :through => :requests,:source => :user_from

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  phone_regex= /([0-9]*)/

  validates :name, :presence => true,
                   :length   => { :maximum => 50 }
  validates :email,:presence => true,
                   :format   => { :with => email_regex },
                   :uniqueness => { :case_sensitive => false }
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
  validates :city, :length => {:maximum => 15}
  validates :about, :length => {:maximum => 100}
  validates :status, :length => {:maximum => 70}
  validates :phone, :format => {:with => phone_regex}


  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def is_blocked?
    self.blocked?
  end


  def friends?(friend)
    relationships.find_by_friend_id(friend)
  end

  def make_friends!(friend)
    relationships.create!(:friend_id => friend.id)
    user=User.find_by_id(friend.id)
    user.relationships.create!(:friend_id => id)
  end


  def get_request!(user)
    requests.create!(:user_from_id => user.id)
  end

  def send_request?(user)
    user.requests.find_by_user_from_id(self)
  end

  def remove_request!(user)
    requests.find_by_user_from_id(user).destroy
  end

  def destroy_friendship!(friend)
    relationships.find_by_friend_id(friend).destroy
    friend.relationships.find_by_friend_id(self).destroy
  end

  def optional_fields?
    if data_of_burn?
      return true
    end
    if sex?
      return true
    end
    if phone?
      return true
    end
    if city?
      return true
    end
    if about?
      return true
    end
    false
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end
