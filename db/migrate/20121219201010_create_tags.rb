class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end
    add_index :tags, :name
    add_index :tags, [:name, :created_at]
  end
end
