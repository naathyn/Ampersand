class MessagesController < ApplicationController
  before_filter :correct_user, only: :destroy

  def create
    @message = current_user.messages.build(params[:content])
    if @message.save
      flash[:success] = "Your post has been submitted!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @message.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @message = feed_item.find_by_id(params[:id])
      redirect_to root_url if @message.nil?
    end
end
