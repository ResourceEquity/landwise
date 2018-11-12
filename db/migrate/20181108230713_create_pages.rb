class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :title
      t.boolean :show_in_menu, default: false
      t.text :body
      t.string :keywords
      t.string :description
      t.string :slug
      t.integer :position

      t.timestamps
    end
  end
end
