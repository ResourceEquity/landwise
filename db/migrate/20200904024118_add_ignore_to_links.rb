class AddIgnoreToLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :ignore, :boolean, default: false
  end
end
