class AddRecordsUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :records_users, id: false do |t|
      t.integer :record_id
      t.integer :user_id
    end
  end
end
