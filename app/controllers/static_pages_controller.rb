class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @title = "@#{current_user.name}"
      @shares = current_user.share.paginate(page: params[:page],
                include:  [ :likes, :fans, :user => {
                            :captchas => { :user => :fans } }
                          ])
      @micropost = current_user.microposts.build
    else
      @title = "Sign up now!"
    end
  end

  def about
    @title = "About"
  end
end
