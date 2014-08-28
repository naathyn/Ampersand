class PagesController < ApplicationController

  def home
    updates_page_link = "<a href=" + "https://github.com/naathyn/Ampersand/commits/master/" + " target=_blank>"
    update_title = "<b>Various Touchups</b>"
    update_header = "#{updates_page_link} #{update_title} </a>".html_safe

    @notice = "Last updated on Monday, August 28th at 3:30 a.m. #{update_header}: Keeping the gems updated to keep Ampersand shiny. :)."

    if signed_in?
      @title = current_user.username
      @shares = current_user.share.page(params[:page])
      @micropost = current_user.microposts.build
      @messages = Message.includes(:user) 
      show_chatters if @messages.any? &&
        @messages.last.created_at > 1.day.ago
    else
      @title = "Get Started Now!"
    end
  end

  def about
    @title = "About Ampersand"
  end

private

  def show_chatters
      @users = @messages.map { |message|
        message.user }

      user_names = @users.map { |u| u.realname }.uniq.join(', ')
      with_user_size = @users.size > 1 ? "were" : "was"

      @message = "<b>#{user_names}</b> #{with_user_size} in the chatroom today!
        They may still be chatting, come say hello!"
  end
end
