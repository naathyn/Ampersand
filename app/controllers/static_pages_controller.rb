class StaticPagesController < ApplicationController

  def home
    if signed_in?
<<<<<<< HEAD
      @micropost = current_user.microposts.build
=======
      @micropost = current_user.microposts.build if signed_in?
>>>>>>> posting
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
