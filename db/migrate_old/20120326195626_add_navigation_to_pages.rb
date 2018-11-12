class AddNavigationToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :navigation, :boolean, default: false
  end
end
