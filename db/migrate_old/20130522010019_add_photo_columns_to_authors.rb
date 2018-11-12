class AddPhotoColumnsToAuthors < ActiveRecord::Migration[4.2]
  def change
    add_column :authors, :photo_file_name,    :string
    add_column :authors, :photo_content_type, :string
    add_column :authors, :photo_file_size,    :integer
    add_column :authors, :photo_updated_at,   :datetime
  end
end