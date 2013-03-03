class AddTaggingCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :tagging_count, :integer, default: 0
  end
end
