class CreatePages < ActiveRecord::Migration[4.2]
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.string :browser_title
      t.string :keywords
      t.text :description
      t.string :slug
      t.integer :user_id

      t.timestamps
    end
  end
end
