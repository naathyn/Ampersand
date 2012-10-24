class CreateVersions < ActiveRecord::Migration
  def self.up
  end
  def self.down
  drop_table :versions
  end
end
