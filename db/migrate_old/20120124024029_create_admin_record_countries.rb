class CreateAdminRecordCountries < ActiveRecord::Migration[4.2]
  def change
    create_table :record_countries do |t|
      t.string :name
    end

    add_column :records, :record_country_id, :integer
  end
end
