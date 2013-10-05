class AddSlugToTable < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
    add_column :tags, :slug, :string
    add_index :tags,  :slug, unique: true
    add_column :blogs, :slug, :string
    add_index :blogs, :slug, unique: true
  end
end
