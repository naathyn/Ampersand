class AddIndexToMicroposts < ActiveRecord::Migration
  def change
    add_index :microposts, :to_id
  end
end
