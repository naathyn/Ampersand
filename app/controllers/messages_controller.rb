class MessagesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def create
    @message = current_user.messages.build(params[:message])
    if @message.save
      flash[:success] = "Your message has been sent!"
      redirect_to root_url
    else
      @inbox_items = []
      render 'static_pages/connect'
    end
  end

  def destroy
    @message.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @message = current_user.messages.find_by_id(params[:id])
      redirect_to root_url if @message.nil?
    end
end
