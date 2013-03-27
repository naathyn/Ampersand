class TagsController < ApplicationController
  before_filter :signed_in_user

  def show
    @tag = Tag.find(params[:id])
    @title = "Blogs tagged with \"#{@tag.name}\""
    @blogs = @tag.blogs.page(params[:page]).order('comment_count DESC')
  end
end
