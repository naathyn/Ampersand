class AddIndexToMicropostsObjects < ActiveRecord::Migration
  def change
    add_index :microposts, [:to_id, :created_at]
    add_index :microposts, [:user_id, :to_id]
  end
end
