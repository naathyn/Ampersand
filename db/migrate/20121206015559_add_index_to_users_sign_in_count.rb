class AddIndexToUsersSignInCount < ActiveRecord::Migration
  def change
    add_index :users, :sign_in_count
  end
end
