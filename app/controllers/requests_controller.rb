class RequestsController < ApplicationController
  def create
    @user = User.find(params[:request][:user_id])
    @user.get_request!(current_user)
    respond_to do |format|
      format.html do
        flash[:success] = " #{@user.name} will get you request to friends."
        redirect_to @user
      end
      format.js
    end
  end

  def destroy
    @user = Request.find(params[:id]).user_from
    current_user.remove_request!(@user)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end
end
