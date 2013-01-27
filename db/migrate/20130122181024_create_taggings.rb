class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :blog_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :taggings, :blog_id
    add_index :taggings, :tag_id
    add_index :taggings, [:blog_id, :tag_id], :unique => true
  end
end
