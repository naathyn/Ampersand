class OpinionsController < ApplicationController
	before_filter :signed_in_user

  respond_to :html, :js

  def create
    @micropost = Micropost.find(params[:opinion][:like_id])
		current_user.like!(@micropost)
		respond_with @micropost
	end

  def destroy
    @micropost = Opinion.find(params[:id]).like
    current_user.unlike!(@micropost)
    respond_with @micropost
  end
end
