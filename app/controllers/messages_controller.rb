class MessagesController < ApplicationController

  respond_to :html, :js

  def create
    @message = current_user.messages.build(params[:message])
    @messages = current_user.chat.page(params[:page])
    respond_with @message if @message.save
  end
end
