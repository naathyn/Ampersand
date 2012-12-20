class HashtagsController < ApplicationController

  def show
  	@hashtag = Hashtag.find(params[:id])
  	@microposts = @hashtag.microposts.page(params[:page])
  end
end
