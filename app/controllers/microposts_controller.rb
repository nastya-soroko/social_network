class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create,:destroy]
  before_filter :authorized_user, :only=>:destroy

  def create
		@micropost  = current_user.microposts.build(params[:micropost])
		if @micropost.has_nonempty_content?&&@micropost.save
      respond_to do |format|
        format.html  do
          flash[:success] = "Micropost created"
          redirect_to @micropost.user
        end
        format.js 
      end
    else
      render 'pages/home'
		end		
  end

  def destroy
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_back_or @micropost.user }
      format.js
    end
  end

  private
    def authorized_user
      @micropost = Micropost.find_by_id(params[:id])
      redirect_to current_user if @micropost.nil?
    end
end

