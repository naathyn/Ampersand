class BlogsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def show
    @blog = Blog.find(params[:id])
    @user = @blog.user
    @title = "#{@blog.title} by #{@user.realname}"
    @comments = @blog.comments.page(params[:page])
    @comment = current_user.comments.build
  end

  def new
    @blog = current_user.blogs.build
    @title = "New Blog Entry - #{Time.now.to_s(:long_ordinal).gsub(/\d+:\d+/, '')}"
  end

  def create
    @blog = current_user.blogs.build(params[:blog])
    if @blog.save
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      @title = "Please Try Again"
      render :new
    end
  end

  def edit
    @blog = current_user.blogs.find(params[:id])
    @title = "Editing: #{@blog.title}"
  end

  def update
    Blog.record_timestamps = false
    @blog = current_user.blogs.find(params[:id])
    if @blog.update_attributes(params[:blog])
      redirect_to @blog, notice: 'Your blog was updated successfully.'
    else
      @title = "Please Try Again"
      render :edit
    end
  end

  def destroy
    @blog = current_user.blogs.find(params[:id])
    @blog.tags.destroy && @blog.destroy
    redirect_to blog_user_url(current_user), notice: 'Your blog was removed.'
  end

private

  def correct_user
    @blog = current_user.blogs.find_by_id(params[:id])
    redirect_to :root unless @blog
  end
end
