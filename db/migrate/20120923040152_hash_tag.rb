class HashTag < ActiveRecord::Migration
  def change
		create_table :hash_tags do |t|
			t.integer :micropost_id
			t.integer :tag_id

			t.timestamps
		end
	add_index :hash_tags, [:micropost_id, :tag_id]
	end
end
