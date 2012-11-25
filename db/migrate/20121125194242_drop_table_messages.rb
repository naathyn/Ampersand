class DropTableMessages < ActiveRecord::Migration
  def change
    drop_table :messages
  end
end
