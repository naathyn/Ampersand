class ChangeTableUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :bio, :text
    add_index :users, :created_at
    remove_index :users, [:email, :realname]
    remove_index :users, [:name, :email]
    remove_column :users, :online
  end

  def self.down
    change_column :users, :bio, :string
    remove_index :users, :created_at
    add_index :users, [:email, :realname]
    add_index :users, [:name, :email]
    add_column :users, :online
  end
end
