class AddDescriptionToRecords < ActiveRecord::Migration[4.2]
  def change
    add_column :records, :description, :text
  end
end
