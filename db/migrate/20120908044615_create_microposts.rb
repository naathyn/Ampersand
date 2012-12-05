class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content
      t.integer :user_id
      t.integer :to_id

      t.timestamps
    end
    add_index :microposts, :user_id
    add_index :microposts, :to_id
    add_index :microposts, [:user_id, :to_id]
    add_index :microposts, [:user_id, :created_at], :unique => true
    add_index :microposts, [:to_id, :created_at], :unique => true 
  end
end
