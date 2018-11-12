class CreateUserCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_categories do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps

      t.index [:category_id, :user_id]
      t.index [:user_id, :category_id]
    end
  end
end
