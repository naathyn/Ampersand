class BlogsController < ApplicationController
  before_filter :signed_in_user, except: :show
  before_filter :correct_user, only: :destroy
  before_filter :remove_stale_tags, only: [:create, :update, :destroy]
  before_action :set_blog, only: [:show, :edit, :update]

  def show
    @user = @blog.user
    @title = "#{@blog.title} by #{@user.realname}"
    @comments = @blog.comments.paginate(page: params[:page], include: :user)
    @comment = current_user.comments.build if signed_in?
  end

  def new
    @blog = current_user.blogs.build
    @title = "New Blog Entry - #{Time.now.to_s(:long_ordinal).gsub(/\d+:\d+/, '')}"
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      @title = "Please Try Again"
      render :new
    end
  end

  def edit
    @title = "Editing: #{@blog.title}"
  end

  def update
    Blog.record_timestamps = false
    if @blog.update_attributes(blog_params)
      redirect_to @blog, notice: 'Your blog was updated successfully.'
    else
      @title = "Please Try Again"
      render :edit
    end
  end

  def destroy
    @blog.destroy && @blog.taggings.clear
    redirect_to blog_user_url(current_user), notice: 'Your blog was removed.'
  end

private

  def set_blog
    @blog = Blog.friendly.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :tag_names, :photo)
  end

  def correct_user
    @blog = current_user.blogs.friendly.find(params[:id])
    redirect_to :root if @blog.nil?
  end

protected

  def remove_stale_tags
    Tag.find_each { |tag| tag.destroy if tag.blogs.empty? }
  end

end
