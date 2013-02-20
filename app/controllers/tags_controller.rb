class TagsController < ApplicationController
  before_filter :signed_in_user

  def show
    @tag = Tag.find(params[:id])
    @title = "Tags with #{@tag.name}"
    @blogs = @tag.blogs.paginate(page: params[:page], include: [:tags, :user])
  end
end
