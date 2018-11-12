class AddTimestampsToSubBlocks < ActiveRecord::Migration[4.2]
	def up
		add_column(:sub_blocks, :created_at, :datetime)
		add_column(:sub_blocks, :updated_at, :datetime)
	end
end
