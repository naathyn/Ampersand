class DropTableTags < ActiveRecord::Migration
  def change
    drop_table :tags
    drop_table :hashtags
  end
end
