class Tag < ActiveRecord::Migration
  def change
		create_table :tags do |t|
			t.string :word

			t.timestamps
		end
	add_index :tags, :word
	end
end
