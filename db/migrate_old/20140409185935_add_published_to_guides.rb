class AddPublishedToGuides < ActiveRecord::Migration[4.2]
  def change
    add_column :guides, :published, :integer
  end
end
