class CreateResponsibilityRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :responsibility_records do |t|
      t.references :responsibility, foreign_key: true
      t.references :record, foreign_key: true

      t.timestamps

      t.index [:responsibility_id, :record_id]
      t.index [:record_id, :responsibility_id]
    end
  end
end
