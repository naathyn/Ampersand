class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @title = "@#{current_user.name}"
      @shares = current_user.share.paginate(page: params[:page], include: [:user => :captchas])
      @micropost = current_user.microposts.build
    else
      @title = "Sign up now!"
    end
  end

  def about
  end
end
