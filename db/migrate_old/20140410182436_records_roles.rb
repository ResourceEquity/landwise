class RecordsRoles < ActiveRecord::Migration[4.2]
  def up
  	create_table :records_roles do |t|
  	  t.integer :record_id
  	  t.integer :role_id
    end
  end

  def down
  	drop_table :records_roles
  end
end
