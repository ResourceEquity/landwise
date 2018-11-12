class RenameRecordsAuthorField < ActiveRecord::Migration[4.2]
  def change
    rename_column :records, :author, :creator
  end
end
