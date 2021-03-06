class MessagesController < ApplicationController
  before_filter :signed_in_user

  respond_to :js

  def create
    @message = current_user.messages.build(message_params)
    @messages = Message.includes(:user).page(params[:page])
    respond_with @message if @message.save
  end

private

  def message_params
    params.require(:message).permit(:content)
  end
end
