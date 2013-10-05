class CommentsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  before_action :find_blog, only: [:create, :destroy]

  def new
    @comment = current_user.comments.build
    @title = "New Comment"
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.blog_id = @blog.id
    if @comment.save
      flash[:success] = "Your comment has been posted."
      redirect_to "#{entry_url(@blog)}#comments"
    else
      @title = "Please try again."
      render :new
    end
  end

  def destroy
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to entry_url(@blog), notice: "Your comment was removed."
  end

private

  def find_blog
    @blog = Blog.friendly.find(params[:blog_id])
  end

  def comment_params
    params.require(:comment).permit(:blog_id, :content)
  end

protected

  def correct_user
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to :root if @comment.nil?
  end
end
