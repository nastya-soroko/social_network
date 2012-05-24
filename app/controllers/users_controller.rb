require 'will_paginate/array'
class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show,:new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def new
    @user=User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @from_users=Array.new
    @feed_posts =@user.microposts
    @feed_posts.each do |x|
      @from_users.push(User.find_by_id(x.from_id))
    end
    @feed_items=@feed_posts.zip(@from_users)
    @title = @user.name
    @micropost = Micropost.new(:from_id =>current_user.id,:user_id => @user.id)
    @friends = @user.friends.paginate(:page => params[:page],:per_page=>10)
  end

  def create

    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "The confirmation was sended!"
      redirect_to @user
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
					if @user.update_attributes(params[:user])
						flash[:success] = "Profile updated."
						redirect_to @user
					else
						@title = "Edit user"
						render 'edit'
					end
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
    @senders=@user.senders
    @friends = @user.friends.paginate(:page => params[:page],:per_page=>10)
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
