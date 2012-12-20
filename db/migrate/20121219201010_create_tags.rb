class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :micropost_id
      t.integer :hashtag_id

      t.timestamps
    end
    add_index :tags, :micropost_id
    add_index :tags, :hashtag_id
    add_index :tags, [:micropost_id, :hashtag_id], :unique => true
    add_index :tags, [:micropost_id, :created_at]
    add_index :tags, [:hashtag_id, :created_at]
    add_index :tags, [:micropost_id, :hashtag_id, :created_at]
  end
end
