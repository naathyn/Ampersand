class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :blog_id
      t.text :content

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :blog_id
    add_index :comments, [:user_id, :blog_id]
  end
end
