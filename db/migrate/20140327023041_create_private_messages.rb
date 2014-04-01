class CreatePrivateMessages < ActiveRecord::Migration
  def change
    create_table :private_messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.text :content
      t.datetime :read_at
      t.boolean :sender_deleted, default: false
      t.boolean :recipient_deleted, default: false

      t.timestamps
    end
    add_index :private_messages, :sender_id
    add_index :private_messages, :recipient_id
    add_index :private_messages, [:sender_id, :recipient_id]
    add_index :private_messages, :read_at
    add_index :private_messages, :created_at
  end
end
