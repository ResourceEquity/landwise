class AddParentIdToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :parent_id, :integer, default: 0
  end
end
