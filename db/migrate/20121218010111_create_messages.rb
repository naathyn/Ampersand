class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :to_id
      t.text    :content

      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :to_id
    add_index :messages, [:user_id, :to_id]
    add_index :messages, [:user_id, :created_at]
    add_index :messages, [:to_id, :created_at]
    add_index :messages, [:user_id, :to_id, :created_at]
  end
end
