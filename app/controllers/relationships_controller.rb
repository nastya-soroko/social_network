class RelationshipsController < ApplicationController
  before_filter :authenticate

  def create
    @user = User.find(params[:relationship][:friend_id])
    current_user.make_friends!(@user)
    current_user.remove_request!(@user)
    respond_to do |format|
      format.html {  redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).friend
    current_user.destroy_friendship!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
