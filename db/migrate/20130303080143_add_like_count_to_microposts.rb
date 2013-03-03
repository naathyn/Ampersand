class AddLikeCountToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :like_count, :integer, default: 0
  end
end
