class BlogsController < ApplicationController
  before_filter :signed_in_user
  before_filter :remove_stale_tags, only: [:create, :destroy]

  def create
    @blog = current_user.blogs.build(params[:blog])
    if @blog.save
      redirect_to(blog_user_url(current_user), notice: 'Blog was successfully created.')
    else
      @blogs = []
      render 'users/blog'
    end
  end

  def destroy
    @blog = current_user.blogs.find(params[:id])
    @blog.destroy
    redirect_to(blog_user_url(current_user), notice: 'Your blog was removed.')
  end

private

  def remove_stale_tags
    Tag.all.each { |tag| tag.delete if tag.blogs.empty? }
  end
end
