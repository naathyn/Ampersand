class AddIndexToOpinions < ActiveRecord::Migration
  def change
		add_index :opinions, :fan_id
		add_index :opinions, :like_id
    add_index :opinions, [:fan_id, :like_id], unique: true
  end
end
