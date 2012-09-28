class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :convo
      t.integer :user_id
      t.integer :to_id

      t.timestamps
    end
			add_index :messages, :user_id
			add_index :messages, :to_id
			add_index :messages, [:user_id, :created_at]
  end
end
