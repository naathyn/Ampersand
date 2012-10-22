class StaticPagesController < ApplicationController

  def home
		if signed_in?
			@title = "@#{current_user.name}"
			@micropost = current_user.microposts.build
    	@share_items = current_user.share.paginate(page: params[:page])
		else
		  @title = "Sign up now!"
	  end
  end

  def updates
  end

  def about
  end

  def contact
  end

  def connect
    if signed_in?
			@title = "!#{current_user.name}"
      @message = current_user.messages.build
      @inbox_items = current_user.inbox.paginate(page: params[:page])
		else
      redirect_to signin_path
      flash[:notice] = "Please signin to view your inbox"
    end
  end
end
