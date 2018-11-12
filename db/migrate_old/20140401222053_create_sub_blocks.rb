class CreateSubBlocks < ActiveRecord::Migration[4.2]
  def up
  	create_table :sub_blocks do |t|
  		t.string :title
  		t.text :content_block
  		t.integer :subguide_id
  	end
  end

  def down
  end
end
