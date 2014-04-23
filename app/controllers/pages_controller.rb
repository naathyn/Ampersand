class PagesController < ApplicationController

  def home
    @notice = "Last updated on Tuesday, April 22nd at 11:00 p.m.
      Your inbox has been fixed up a bit, updated to Rails 4.1.0,
      and getting ready to start on notifications ;)"
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
