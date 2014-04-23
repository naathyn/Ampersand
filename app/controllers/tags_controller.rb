class TagsController < ApplicationController

  before_filter :signed_in_user

  def show
    @tag = Tag.friendly.find(params[:id])
    @title = "Blogs tagged with \"#{@tag.name}\""
    @blogs = @tag.blogs.includes(User::BLOG_EAGER_LOADING).
      page(params[:page]).order('comment_count DESC')
  end
end
