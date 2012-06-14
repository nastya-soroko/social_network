require 'spec_helper'

describe RelationshipsController do

  describe "access control" do

    it "should require signin for create" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should require signin for destroy" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  
  describe "DELETE 'destroy'" do

    before(:each) do
      @user = test_sign_in(FactoryGirl.create(:user))
      @friend = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
      @user.make_friends!(@friend)
      @relationship = @user.relationships.find_by_friend_id(@friend)
    end

    it "should destroy a relationship" do
      lambda do
        delete :destroy, :id => @relationship
        response.should be_redirect
      end.should change(Relationship, :count).by(-2)
    end

    it "should destroy a relationship using Ajax" do
      lambda do
        xhr :delete, :destroy, :id => @relationship
        response.should be_success
      end.should change(Relationship, :count).by(-2)
    end
  end

end
