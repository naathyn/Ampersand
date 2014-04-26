class PagesController < ApplicationController

  def home
    updates_page_link = "<a href=" + "https://github.com/naathyn/Ampersand/commits/master/" + " target=_blank>"
    update_title = "<b>Various Touchups</b>"
    update_header = "#{updates_page_link} #{update_title} </a>".html_safe
    @notice = "Last updated on Saturday, April 26th at 9:00 a.m. #{update_header}: Blog and tag pages, mailbox layout and other site enhancements as well as layout improvements."
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
