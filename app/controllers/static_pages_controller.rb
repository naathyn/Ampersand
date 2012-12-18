class StaticPagesController < ApplicationController
  before_filter :signed_in_user, only: :chat

  def home
    if signed_in?
      @title = "@#{current_user.name}"
      @micropost = current_user.microposts.build
      @shares = current_user.share.page(params[:page])
    else
      @title = "Sign up now!"
    end
  end

  def about
  end
end
