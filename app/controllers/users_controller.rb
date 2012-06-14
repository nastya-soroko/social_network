class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show,:new, :create,:activate]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def new
    @user=User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

	def activate
		@user=User.find_with_decode(params[:id])
		@user.update_attribute(:activated,true)
		sign_in @user
		redirect_to @user
	end

  def create
    @user = User.new(params[:user])
    if @user.save
			UserMailer.welcome_email(@user).deliver
      flash[:success] = "The confirmation was sended!"
      redirect_to root_path
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
   	respond_to do |format|
			format.html do
				@user.update_attributes(params[:user])
				flash[:success] = "Profile updated."
				redirect_to @user					
			end
			format.js do
				@user.update_attribute(:status,params[:status])
			end
    end
	end

  def index
    @title = "All users"
    @users = User.paginate(:page=>params[:page],:per_page=>10)
  end

  def destroy
    user=User.find(params[:id])
    if user.blocked?
      user.update_attribute(:blocked,false)
      flash[:success] = "User was unblocked."
    else
      user.update_attribute(:blocked,true)
      flash[:success] = "User was blocked."
    end
    redirect_to users_path
  end

  def friends
    @title = "Friends"
    @user = User.find(params[:id])
    render 'show_friends'
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      if current_user==nil
        redirect_to(signin_path)
      elsif !current_user.admin?
        redirect_to(root_path)
      end
    end

end
