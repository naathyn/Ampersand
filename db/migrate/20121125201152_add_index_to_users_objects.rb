class AddIndexToUsersObjects < ActiveRecord::Migration
  def change
    add_index :users, :online
  end
end
