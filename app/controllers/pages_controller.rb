class PagesController < ApplicationController

  def home
    if signed_in?
      @title = current_user.username
      @shares = current_user.share.paginate(page: params[:page],
        include: User::FEED_EAGER_LOADING)
      @users = Message.find(:all, include: :user).map { |message|
        message.user.realname
      }.uniq.join ', '
      @micropost = current_user.microposts.build
    else
      @title = "Sign up now!"
    end
  end

  def about
    @title = "About"
  end
end
