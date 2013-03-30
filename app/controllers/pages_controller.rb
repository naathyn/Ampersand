class PagesController < ApplicationController

  def home
    if signed_in?
      @title = current_user.username
      @shares = current_user.share.paginate(page: params[:page],
                include: User::FEED_EAGER_LOADING)
      @micropost = current_user.microposts.build
      @users = current_user.chat.map { |message|
        message.user.realname
      }.uniq.join(', ')
    else
      @title = "Sign up now!"
    end
  end

  def about
    @title = "About"
  end
end
