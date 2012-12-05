class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :realname
      t.string  :email
      t.string  :name
      t.string  :location
      t.text    :bio
      t.boolean :online
      t.integer :sign_in_count, :default => 0
      t.boolean :admin, :default => false
      t.string  :password_digest
      t.string  :remember_token

      t.timestamps
    end
    add_index :users, [:realname, :name, :email], :unique => true
    add_index :users, [:name, :email], :unique => true
    add_index :users, [:email, :realname], :unique => true
    add_index :users, [:realname, :name], :unique => true
    add_index :users, :realname, :unique => true
    add_index :users, :email, :unique => true
    add_index :users, :name, :unique => true
    add_index :users, :location
    add_index :users, :sign_in_count
    add_index :users, :online
    add_index :users, :remember_token
  end
end
