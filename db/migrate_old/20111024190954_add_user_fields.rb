class AddUserFields < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :name, :string
    add_column :users, :organization, :string
    add_column :users, :phone, :string
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :bio, :text
    add_column :users, :languages, :string
    add_column :users, :avatar_file_name,    :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size,    :integer
    add_column :users, :avatar_updated_at,   :datetime
  end
end
