class AddRecordJurisdictionId < ActiveRecord::Migration[4.2]
  def change
    add_column :records, :item_jurisdiction_id, :integer
  end
end
