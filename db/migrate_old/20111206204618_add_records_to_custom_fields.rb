class AddRecordsToCustomFields < ActiveRecord::Migration[4.2]
  def change
    create_table :custom_values do |t|
      t.integer :record_id
      t.integer :custom_field_id
      t.string :value
    end
  end
end
