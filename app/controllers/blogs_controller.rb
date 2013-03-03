class BlogsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy
  before_filter :skip_timestamps, only: :update

  def show
    @blog = Blog.find(params[:id])
    @user = @blog.user
    @title = "#{@blog.title} by #{@user.realname}"
    @comments = @blog.comments.page(params[:page])
    @comment = current_user.comments.build
  end

  def new
    @blog = current_user.blogs.build
    @title = "New Blog Entry - #{Time.now.to_s(:long_ordinal)}"
  end

  def create
    @blog = current_user.blogs.build(params[:blog])
    if @blog.save
      redirect_to blog_user_url(current_user), notice: 'Blog was successfully created.'
    else
      render :new
    end
  end

  def edit
    @blog = current_user.blogs.find(params[:id])
    @title = "Editing: #{@blog.title}"
  end

  def update
    @blog = current_user.blogs.find(params[:id])
    if @blog.update_attributes(params[:blog])
      redirect_to blog_user_url(current_user), notice: 'Your blog was updated successfully.'
    else
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
    redirect_to root_url unless @blog
  end

  def skip_timestamps
    Blog.record_timestamps = false
  end
end
