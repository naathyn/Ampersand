class UsersController < ApplicationController
  before_filter :signed_in_user, except: [:new, :create]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :captcha_user, only: :captchas
  before_filter :wipe_the_chat, only: :chatroom

  def index
    @users = User.page(params[:page]).order('created_at DESC')
  end

 def show
    @user = User.find(params[:id])
    @replies    = @user.replies.paginate(page: params[:page], include: [:user => 
    {:followed_users => {:followers => :opinions}}])
    @microposts = @user.microposts.paginate(page: params[:page], include: [:user => 
    {:followed_users => {:followers => :opinions}}])
    @following  = @user.followed_users.paginate(page: params[:page], include: :relationships)
    @followers  = @user.followers.paginate(page: params[:page], include: :relationships)
    @micropost  = current_user.microposts.build
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome, and thanks for joining!  
      Why don't you edit your profile and tell us a little about yourself?  
      Whenever you're ready, hit Home to check out your feed.  
      Post some content and follow members to fill it up!"
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
    @title = @user.realname
    @active = "Following"
    @users = @user.followed_users.page(params[:page])
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @title = @user.realname
    @active = "Followers"
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  def captchas
    @user = User.find(params[:id])
    @captchas = @user.captchas.page(params[:page]).order('created_at DESC')
    @captcha = current_user.captchas.build
    render 'captchas/index'
  end

  def chatroom
    @messages = current_user.chat.paginate(page: params[:page], per_page: 15, 
    include: [:user => :relationships])
    render 'chat'
  end

private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def captcha_user
      @user = User.find(params[:id])
      redirect_to(captchas_user_path(current_user)) unless current_user?(@user)
    end

    def wipe_the_chat
      @messages = current_user.chat
      @messages.all.each do |message|
        if message.created_at<=(1.day.ago)
          message.delete
        end
      end
    end
end
