class AddReadToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :read, :boolean, :default => false
  end
end
