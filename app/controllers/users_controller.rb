class UsersController < ApplicationController
  before_filter :signed_in_user, :except => [:new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  def index
    @users = User.page(params[:page])
    @title = "Members (#{@users.count})"
  end

  def show
    @user = User.find(params[:id])
    @title = "#{@user.realname}"
    @profile_items = @user.profile.page(params[:page])
    @atreply_items = current_user.atreply.page(params[:page])
    @micropost = current_user.microposts.build
    @captchas = current_user.captchas.page(params[:page]).order('created_at DESC')
    @captcha = current_user.captchas.build
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome, and thanks for joining!  Why don't you edit your profile and tell us a little about yourself?  Whenever you're ready, hit Home to check out your feed.  Post some content and follow members to fill it up!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated successfully"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User removed"
    redirect_to users_url
  end

  def following
    @user = User.find(params[:id])
    @title = "@#{@user.name} | Following (#{@user.followed_users.count})"
    @active = "Following"
    @users = @user.followed_users.page(params[:page])
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @title = "@#{@user.name} | Followers (#{@user.followers.count})"
    @active = "Followers"
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  def online
    @users = User.where(:online => true).page(params[:page])
    render 'online_users'
  end

private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_url(current_user)) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
