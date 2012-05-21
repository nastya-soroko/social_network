class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create,:destroy]
  before_filter :authorized_user, :only=>:destroy

  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created"
      redirect_to @micropost.user
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
      @micropost.destroy
      redirect_back_or current_user
  end

  private
    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to current_user if @micropost.nil?
    end
end

