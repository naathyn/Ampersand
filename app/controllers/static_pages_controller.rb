class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @share_items = current_user.share.paginate(page: params[:page])
    end
  end

  def connect
    if signed_in?
      @message = current_user.messages.build
      @inbox_items = current_user.inbox.paginate(page: params[:page])
    end
  end

  def updates
  end

  def about
  end

  def contact
  end
end
