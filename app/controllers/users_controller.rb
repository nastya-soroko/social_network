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
    @feed_items=@feed_posts.zip(@from_users).paginate(:page => params[:page],:per_page => 10)
    @title = @user.name
    @micropost = Micropost.new(:from_id =>current_user.id,:user_id => @user.id)

  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the SocialNetwork!"
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
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def index
    @title = "All users"
    @users = User.paginate(:page=>params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def friends
    @title = "Friends"
    @user = User.find(params[:id])
    @users = @user.friends.paginate(:page => params[:page])
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
