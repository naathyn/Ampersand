class CreateCaptchas < ActiveRecord::Migration
  def change
    create_table :captchas do |t|
      t.integer :user_id
      t.text :content

      t.timestamps
    end
    add_index :captchas, :user_id
    add_index :captchas, [:user_id, :created_at]
  end
end
