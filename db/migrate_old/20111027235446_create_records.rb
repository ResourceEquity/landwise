class CreateRecords < ActiveRecord::Migration[4.2]
  def change
    create_table :records do |t|
      t.string :title
      t.string :author
      t.string :country
      t.boolean :published, :default => true
      t.integer :record_collection_type_id
      t.integer :user_id

      t.timestamps
    end
  end
end
