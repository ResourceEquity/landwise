class AlterItemsDateField < ActiveRecord::Migration[4.2]
  def change
    add_column :items, :publication_year, :integer
  end
end
