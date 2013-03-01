class BlogsController < ApplicationController
  before_filter :signed_in_user
  before_filter :remove_stale_tags, only: [:create, :update, :destroy]
  before_filter :skip_timestamps, only: :update

  def show
    @blog = Blog.find(params[:id])
    @user = @blog.user
    @title = "#{@blog.title} by #{@user.realname}"
    @comments = @blog.comments.page(params[:page])
    @comment = current_user.comments.build 
  end

  def create
    @blog = current_user.blogs.build(params[:blog])
    if @blog.save
      redirect_to blog_user_url(current_user), notice: 'Blog was successfully created.'
    else
      @blogs = []
      render 'users/blog'
    end
  end

  def edit
    @blog = current_user.blogs.find(params[:id])
    @title = "Editing: #{@blog.title}"
  end

  def update
    @blog = current_user.blogs.find(params[:id])
    if @blog.update_attributes(params[:blog])
      redirect_to blog_user_url(current_user), notice: 'Your blog was posted successfully.'
    else
      render :edit
    end
  end

  def destroy
    @blog = current_user.blogs.find(params[:id])
    @blog.destroy
    redirect_to blog_user_url(current_user), notice: 'Your blog was removed.'
  end

private

  def remove_stale_tags
    Tag.all.each { |tag| tag.delete if tag.blogs.empty? }
  end

  def skip_timestamps
    Blog.record_timestamps = false
  end
end
