class UsersController < ApplicationController
  before_filter :signed_in_user,  except: [:new, :create, :blog, :blogs]
  before_filter :correct_user,    only:   [:edit, :update]
  before_filter :captcha_user,    only:   :captchas
  before_filter :admin_user,      only:   :destroy
  before_filter :wipe_the_chat,   only:   :chatroom

  before_action :set_user, only: [:show, :edit, :destroy, :following, :followers, :blog]

  def index
    @title = "Members"
    @search_users = User.page(params[:page]).order(:realname)
    if params[:search]
      @user = User.find(params[:search])
      redirect_to @user
    else
      @users = User.page(params[:page]).order('updated_at DESC')
    end
  end

 def show
    @title  = @user.username
    @microposts = @user.microposts.paginate(page: params[:page], include: User::FEED_EAGER_LOADING)
    @replies    = current_user.replies.paginate(page: params[:page], include: User::FEED_EAGER_LOADING)
    @following  = @user.followed_users.page(params[:page])
    @followers  = @user.followers.page(params[:page])
  end

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] =
        "Welcome, and thanks for joining!
        Why don't you edit your profile and tell us a little about yourself?
        Whenever you're ready, hit Home to check out your feed.
        Post some content and follow members to fill it up!"
      redirect_to @user
    else
      @title = "Please Try Again"
      render :new
    end
  end

  def edit
    @title = "Account"
  end

  def update
    if @user.update_attributes(user_params)
      sign_in @user
      redirect_to @user, notice: 'Profile updated successfully'
    else
      @title = "Please Try Again"
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to :users, notice: 'User removed'
  end

  def following
    @title = @user.username
    @active = "Following"
    @users = @user.followed_users.page(params[:page])
    render :show_follow
  end

  def followers
    @title = @user.username
    @active = "Followers"
    @users = @user.followers.page(params[:page])
    render :show_follow
  end

  def captchas
    @title = "Captcha's"
    @captchas = @user.captchas.page(params[:page]).order('created_at DESC')
    @captcha = current_user.captchas.build
    render 'captchas/index'
  end

  def blogs
    @title = "Blogs"
    @blogs = Blog.paginate(page: params[:page], include: User::BLOG_EAGER_LOADING).order('updated_at DESC')
    @tags = Tag.paginate(page: params[:page])
  end

  def blog
    @title = "#{@user.realname}'s Blog"
    @blogs = @user.blogs.paginate(page: params[:page], include: User::BLOG_EAGER_LOADING).order('created_at DESC')
    @tags = @user.tags.page(params[:page])
    @blog = current_user.blogs.build if signed_in?
  end

  def chatroom
    @title = "Chatroom"
    @messages = Message.paginate(page: params[:page], include: :user)
    @users = Message.paginate(page: params[:page], include: :user).
              map { |message| message.user }.uniq
    @message = current_user.messages.build
    flash.now[:notice] =
      "Welcome to the chat! All messages are cleared after 24 hours. Happy chatting!"
  end

  def autocomplete
    @users = User.select("realname, name, email").
                  where("name LIKE (?)", "#{params[:query]}%")
  end

private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :realname, :email, :name, :password,
      :password_confirmation, :website, :location, :bio
    )
  end

protected

  def correct_user
    set_user
    redirect_to :root unless current_user?(@user)
  end

  def captcha_user
    set_user
    redirect_to captchas_user_url(current_user),
      notice: "You can find #{@user.username}'s Captcha's in the feeds" unless current_user?(@user)
  end

  def admin_user
    redirect_to :root unless current_user.admin?
  end

  def wipe_the_chat
    Message.all.each { |message| message.destroy if message.created_at < 1.day.ago }
  end
end
