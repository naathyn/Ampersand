class ChangeTableBlogs < ActiveRecord::Migration
  def change
    remove_column :blogs, :extension, :string
    add_column :blogs, :photo, :string
  end
end
