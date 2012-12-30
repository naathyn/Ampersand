class MessagesController < ApplicationController
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @message = current_user.messages.build(params[:message])
    @messages = current_user.chat.paginate(page: params[:page], include: :user)
    respond_with @message if @message.save
  end
end
