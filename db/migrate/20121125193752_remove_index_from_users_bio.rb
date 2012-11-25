class RemoveIndexFromUsersBio < ActiveRecord::Migration
  def change
    remove_index :users, :bio
    remove_index :users, :location
  end
end
