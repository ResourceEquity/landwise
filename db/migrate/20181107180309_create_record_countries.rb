class CreateRecordCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :record_countries do |t|
      t.references :country, foreign_key: true
      t.references :record, foreign_key: true

      t.timestamps

      t.index [:record_id, :country_id]
      t.index [:country_id, :record_id]
    end
  end
end
