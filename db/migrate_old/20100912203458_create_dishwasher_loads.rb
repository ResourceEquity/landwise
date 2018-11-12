class CreateDishwasherLoads < ActiveRecord::Migration[4.2]
	def up
		if !ActiveRecord::Base.connection.table_exists? 'dishwasher_loads'
			create_table :dishwasher_loads do |t|
				t.string :klass
				t.integer :offset
				t.timestamps
			end
		end
	end

	def down
		drop_table :dishwasher_loads
	end
end
