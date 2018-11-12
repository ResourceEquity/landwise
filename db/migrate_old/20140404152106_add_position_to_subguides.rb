class AddPositionToSubguides < ActiveRecord::Migration[4.2]
  def change
    add_column :subguides, :position, :integer
  end
end
