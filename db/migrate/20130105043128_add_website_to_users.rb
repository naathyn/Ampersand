class AddWebsiteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :website, :string
    add_index :users, :website
  end
end
