class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :realname
      t.string :email
      t.string :name
      t.string :location
      t.string :bio
      t.string :password_digest
      t.string :remember_token
      t.boolean :admin, :default => false

      t.timestamps
    end
    add_index :users, :realname, :unique => true
    add_index :users, :email, :unique => true
    add_index :users, :name, :unique => true
    add_index :users, :location
    add_index :users, :bio
    add_index :users, :remember_token
  end
end
