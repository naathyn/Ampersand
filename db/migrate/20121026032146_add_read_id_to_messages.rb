class AddReadIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :read_id, :integer
  end
end
