class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
			t.integer :fan_id
			t.integer :like_id

      t.timestamps
    end
  end
end
