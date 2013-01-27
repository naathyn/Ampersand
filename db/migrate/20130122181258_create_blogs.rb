class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.string :extension

      t.timestamps
    end
    add_index :blogs, :user_id
    add_index :blogs, [:user_id, :created_at]
  end
end
