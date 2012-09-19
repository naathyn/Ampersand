class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :content
      t.integer :user_id
      t.integer :to_id

      t.timestamps
    end
      add_index :replies, [:user_id, :to_id]
  end
end
