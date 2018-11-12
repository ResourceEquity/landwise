class AddPositionToSubBlocks < ActiveRecord::Migration[4.2]
  def change
    add_column :sub_blocks, :position, :integer
  end
end
