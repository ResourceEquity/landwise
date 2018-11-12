class CreateAdminItemJurisdictions < ActiveRecord::Migration[4.2]
  def change
    create_table :item_jurisdictions do |t|
      t.string :name
    end

    add_column :items, :item_jurisdiction_id, :integer
  end
end
