class CreateGuideCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :guide_countries do |t|
      t.references :country, foreign_key: true
      t.references :guide, foreign_key: true

      t.timestamps

      t.index [:guide_id, :country_id]
      t.index [:country_id, :guide_id]
    end
  end
end
