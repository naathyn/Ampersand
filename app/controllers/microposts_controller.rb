class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy
  before_filter :correct_post, only: :show

  def show
    @micropost = Micropost.find(params[:id])
    @title = @micropost.user.realname
    respond_to :html, :js
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Your post has been submitted"
      redirect_to :root
    else
      @title = "Please try again."
      @shares = current_user.share.page(params[:page])
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to :root, notice: "Your post has been removed"
  end

  def likes
    @micropost = Micropost.find(params[:id], include: :likes)
    @microposts = @micropost.fans.paginate(page: params[:page], include: :fans)
    respond_to :js
  end

private

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to :root unless @micropost
  end

  def correct_post
    begin
      @micropost = Micropost.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to :root, notice: "Record not found"
    end
  end
end
