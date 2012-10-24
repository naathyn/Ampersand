class MessagesController < ApplicationController
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @message = current_user.messages.build(params[:message])
    if @message.save
      flash[:success] = "Your message has been sent!"
			redirect_to '/connect'
    else
      @inbox_items = []
      render 'static_pages/connect'
    end
  end
end
