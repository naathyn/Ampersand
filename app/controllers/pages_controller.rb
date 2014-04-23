class PagesController < ApplicationController

  def home
    @notice = "Last updated on Tuesday, April 1st at 9:00 p.m.
        First wave of private messaging. Plans to clean up and simplify soon."
    if signed_in?
      @title = current_user.username
      @shares = current_user.share.page(params[:page])
      @users = Message.includes(:user).page(params[:page]).map { |message|
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
