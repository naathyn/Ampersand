class MessagesController < ApplicationController

  respond_to :html, :js

  def create
    @message = current_user.messages.build(params[:message])
    @messages = current_user.chat.paginate(page: params[:page], per_page: 15)
    @message.save
    respond_with @message
  end
end
