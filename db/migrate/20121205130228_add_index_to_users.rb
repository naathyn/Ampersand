class AddIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, [:realname, :name, :email], :unique => true
    add_index :users, [:name, :email], :unique => true
    add_index :users, [:email, :realname], :unique => true
    add_index :users, [:realname, :name], :unique => true
    add_index :users, :location
  end
end
