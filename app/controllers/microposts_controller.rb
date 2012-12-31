class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  respond_to :html, :js

  def show
    @micropost = Micropost.find(params[:id], include: :likes)
    @title = @micropost.user.realname
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Your share has been posted"
      redirect_to root_url
    else
      @shares = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to(root_url, notice: "Your share has been removed")
  end

  def likes
    @micropost = Micropost.find(params[:id], include: :likes)
    @microposts = @micropost.fans.page(params[:page])
  end

private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to(root_url) if @micropost.nil?
    end
end
