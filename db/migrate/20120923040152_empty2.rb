class CreateHashes < ActiveRecord::Migration
  def change
    create_table :hashes do |t|
      t.string :name

      t.timestamps
    end
    add_index :hashes, [:name, :created_at]
  end
end
