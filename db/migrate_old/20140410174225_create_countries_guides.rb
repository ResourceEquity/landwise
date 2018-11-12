class CreateCountriesGuides < ActiveRecord::Migration[4.2]
  def up
  	create_table :countries_guides do |t|
  	  t.integer :guide_id
  	  t.integer :country_id
    end
  end

  def down
  	drop_table :countries_guides
  end
end
