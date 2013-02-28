class OpinionsController < ApplicationController
  before_filter :signed_in_user

  respond_to :js

  def create
    @micropost = Micropost.find(params[:opinion][:like_id])
    @microposts = @micropost.fans.page(params[:page])
    current_user.like!(@micropost)
    respond_with @micropost
  end

  def destroy
    @micropost = Opinion.find(params[:id]).like
    @microposts = @micropost.fans.paginate(page: params[:page])
    current_user.unlike!(@micropost)
    respond_with @micropost
  end
end
