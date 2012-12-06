class AddSignInCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sign_in_count, :integer, :default => 0
  end
end
