class RepliesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  def create
    @reply = current_user.replies.build(params[:reply])
    if @reply.save
      flash[:success] = "Your reply has been posted!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @reply.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @reply = current_user.replies.find_by_id(params[:id])
      redirect_to root_url if @reply.nil?
    end
end
