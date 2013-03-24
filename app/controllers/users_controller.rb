class UsersController < ApplicationController
  before_filter :signed_in_user, except: [:new, :create, :blogs]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :captcha_user, only: :captchas
  before_filter :admin_user, only: :destroy
  before_filter :wipe_the_chat, only: :chatroom

  def index
    @title = "Members"
    if params[:search]
      @user = User.find(params[:search])
      redirect_to @user
    else
      @users = User.paginate(page: params[:page], per_page: 15).order('updated_at DESC')
    end
  end

 def show
    @user   = User.find_by_name(params[:id])
    @title  = "@#{@user.name}"
    @microposts = @user.microposts.page(params[:page])
    @replies    = current_user.replies.page(params[:page])
    @following  = @user.followed_users.page(params[:page])
    @followers  = @user.followers.page(params[:page])
  end

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] =
"Welcome, and thanks for joining!
Why don't you edit your profile and tell us a little about yourself?
Whenever you're ready, hit Home to check out your feed.
Post some content and follow members to fill it up!"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @title = "Account"
    @user = User.find_by_name(params[:id])
  end

  def update
    if @user.update_attributes(params[:user])
      sign_in @user
      redirect_to @user, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url, notice: 'User removed'
  end

  def following
    @user = User.find_by_name(params[:id])
    @title = "@#{@user.name}"
    @active = "Following"
    @users = @user.followed_users.page(params[:page])
    render :show_follow
  end

  def followers
    @user = User.find_by_name(params[:id])
    @title = "@#{@user.name}"
    @active = "Followers"
    @users = @user.followers.page(params[:page])
    render :show_follow
  end

  def captchas
    @title = "Captchas"
    @user = User.find_by_name(params[:id])
    @captchas = @user.captchas.page(params[:page]).order('created_at DESC')
    @captcha = current_user.captchas.build
    render 'captchas/index'
  end

  def blogs
    @title = "Blogs"
    @blogs = Blog.paginate(page: params[:page], per_page: 10,
              include: [:tags, :user])
    @tags = Tag.page(params[:page])
  end

  def blog
    @user = User.find_by_name(params[:id])
    @title = "#{@user.realname} Blog"
    @blogs = @user.blogs.page(params[:page])
    @blog = current_user.blogs.build
  end

  def chatroom
    @title = "Chatroom"
    @messages = current_user.chat.paginate(page: params[:page],
                  per_page: 15, include: :user)
    flash.now[:notice] =  'Welcome to the Chat! Expect rooms and
                          private messaging soon.'
  end

private

  def correct_user
    @user = User.find_by_name(params[:id])
    redirect_to :root unless current_user?(@user)
  end

  def captcha_user
    @user = User.find_by_name(params[:id])
    redirect_to captchas_user_url(current_user),
      notice: "You can find @#{params[:id]}'s Captcha's in the feeds" unless current_user?(@user)
  end

  def admin_user
    redirect_to :root unless current_user.admin?
  end

  def wipe_the_chat
    current_user.chat.all.each { |message|
      message.destroy if message.created_at <= 6.hours.ago
    }
  end
end
