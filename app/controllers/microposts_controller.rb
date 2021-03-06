class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :micropost_user, only: :destroy
  before_filter :correct_micropost, only: :show

  def show
    @micropost = Micropost.includes(:user).find(params[:id])
    @title = @micropost.user.realname
    respond_to :html, :js
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
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
    @micropost = Micropost.includes(:user, :likes).find(params[:id])
    @microposts = @micropost.fans.includes(:fans).page(params[:page])
    respond_to :js
  end

private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

protected

  def micropost_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to :root if @micropost.nil?
  end

  def correct_micropost
    begin
      @micropost = Micropost.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to :root, notice: "Record not found"
    end
  end
end
