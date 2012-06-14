class RequestsController < ApplicationController
  def create
    @user = User.find(params[:request][:user_id])
    @user.get_request!(current_user)
    respond_to do |format|
      format.html do
        flash[:success] = " #{@request.user.name} will get your request to friends."
        redirect_to @request.user
      end
      format.js 
    end
  end

  def destroy
    Request.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end
end
