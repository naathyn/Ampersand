class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  respond_to :html, :js

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    @modal = current_user.microposts.build
    if @micropost.save
      flash[:success] = "Your share has been posted"
      redirect_to root_url
    else
      @shares = []
      flash.now[:notice] = "Don't look at me..."
      render 'static_pages/home'
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @microposts = @micropost.fans.page(params[:page])
    @modal = current_user.microposts.build
  end

  def destroy
    @micropost.destroy
    flash[:notice] = "Your share has been removed"
    redirect_to root_url
  end

private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to(root_url) if @micropost.nil?
    end
end
