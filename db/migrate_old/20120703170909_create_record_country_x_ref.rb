class CreateRecordCountryXRef < ActiveRecord::Migration[4.2]
  def up
    create_table :record_countries_records, id: false do |t|
      t.integer :record_country_id
      t.integer :record_id
    end
  end

  def down
    drop_table :record_countries_records
  end
end
