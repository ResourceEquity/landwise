class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.references :guide, foreign_key: true
      t.string :title
      t.integer :position

      t.timestamps
    end
  end
end
