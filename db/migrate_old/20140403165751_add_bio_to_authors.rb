class AddBioToAuthors < ActiveRecord::Migration[4.2]
  def change
    add_column :authors, :bio, :text
  end
end
