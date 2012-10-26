class MessagesController < ApplicationController
  before_filter :signed_in_user

  def create
    @message = current_user.messages.build(params[:message])
    if @message.save
      flash[:success] = "Your message has been sent!"
			redirect_to inbox_path
    else
      @inbox_items = []
      render 'static_pages/connect'
    end
  end
end
