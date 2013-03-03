class AddCommentCountToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :comment_count, :integer, default: 0
  end
end
