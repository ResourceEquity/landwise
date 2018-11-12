class AddUserPostalCode < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :postal_code, :string
  end
end
