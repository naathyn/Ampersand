class PagesController < ApplicationController

  def home
    @notice = "Last updated on Tuesday, April 1st at 5:00 p.m.
        First wave of private messaging. Plans to clean up and simplify soon."
    if signed_in?
      @title = current_user.username
      @shares = current_user.share.paginate(page: params[:page],
        include: User::FEED_EAGER_LOADING)
      @users = Message.paginate(page: params[:page], include: :user).map { |message|
        message.user.realname }.uniq.join(', ')
      @micropost = current_user.microposts.build
    else
      @title = "Sign up now!"
    end
  end

  def about
    @title = "About"
  end
end
