class HashtagsController < ApplicationController

  def show
  	@hashtag = Hashtag.find(params[:id])
  	@hashtags = @hashtag.microposts.page(params[:page])
  end
end
