class CommentsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def new
    @comment = current_user.comments.build
    @title = "New Comment"
  end

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = current_user.comments.build(params[:comment])
    @comment.blog_id = @blog.id
    if @comment.save
      flash[:success] = "Your comment has been posted."
      redirect_to "#{entry_url(@blog)}#comments"
    else
      render :new
    end
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to entry_url(@blog), notice: "Your comment was removed."
  end

private

  def correct_user
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to :root unless @comment
  end
end
