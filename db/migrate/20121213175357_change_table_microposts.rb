class ChangeTableMicroposts < ActiveRecord::Migration
  def self.up
    change_column :microposts, :content, :text
    change_column :captchas, :content, :text
    add_index :microposts, [:user_id, :to_id, :created_at]
  end
  def self.down
    change_column :microposts, :content, :string
    change_column :captchas, :content, :string
    remove_index :microposts, [:user_id, :to_id, :created_at]
  end
end
