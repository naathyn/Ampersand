class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :name

      t.timestamps
    end
    add_index :hashtags, :name
    add_index :hashtags, [:name, :created_at]
  end
end
