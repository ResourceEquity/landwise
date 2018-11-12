class AddGuideIdToSubguides < ActiveRecord::Migration[4.2]
  def change
    remove_column :guides, :subguides_id
    add_column :subguides, :guide_id, :integer
  end
end
