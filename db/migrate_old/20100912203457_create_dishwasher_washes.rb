class CreateDishwasherWashes < ActiveRecord::Migration[4.2]
	def up
    if !ActiveRecord::Base.connection.table_exists? 'dishwasher_washes'
  		create_table :dishwasher_washes do |t|
  			t.string :klass
  			t.string :columns
  		end
    end
	end

	def down
		drop_table :dishwasher_washes
	end
end
