require 'spec_helper'

describe Relationship do
  before(:each) do
    @user_friend = FactoryGirl.create(:user)
    @friend = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))

    @relationship = @user_friend.relationships.build(:friend_id => @friend.id)
  end

  it "should create a new instance given valid attributes" do
    @relationship.save!
  end

  describe "friend methods" do

    before(:each) do
      @relationship.save
    end

    it "should have a user_friend attribute" do
      @relationship.should respond_to(:user_friend)
    end

    it "should have the right user_friend" do
      @relationship.user_friend.should == @user_friend
    end

    it "should have a friend attribute" do
      @relationship.should respond_to(:friend)
    end

    it "should have the right friend" do
      @relationship.friend.should == @friend
    end
  end

  describe "validations" do

    it "should require a user_friend_id" do
      @relationship.user_friend_id = nil
      @relationship.should_not be_valid
    end

    it "should require a friend_id" do
      @relationship.friend_id = nil
      @relationship.should_not be_valid
    end
  end
end
