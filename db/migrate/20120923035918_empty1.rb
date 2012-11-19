class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.integer :micropost_id
      t.integer :hash_id

      t.timestamps
    end
    add_index :words, :micropost_id, :unique => true
    add_index :words, :hash_id
    add_index :words, [:micropost_id, :hash_id], :unique => true
  end
end
