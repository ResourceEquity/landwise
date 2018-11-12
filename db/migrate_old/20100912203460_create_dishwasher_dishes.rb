class CreateDishwasherDishes < ActiveRecord::Migration[4.2]
	def up
		if !ActiveRecord::Base.connection.table_exists? 'dishwasher_dishes'
			create_table :dishwasher_dishes do |t|
				t.string :url
				t.integer :status
				t.string :klass
				t.string :error
				t.integer :record_id
				t.timestamps
			end
		end
	end

	def down
		drop_table :dishwasher_dishes
	end
end
