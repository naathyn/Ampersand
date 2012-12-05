class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.integer :fan_id
      t.integer :like_id

      t.timestamps
    end
    add_index :opinions, :fan_id
    add_index :opinions, :like_id
    add_index :opinions, [:fan_id, :like_id], :unique => true
  end
end
