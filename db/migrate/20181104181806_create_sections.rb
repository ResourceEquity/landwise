class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.references :article, foreign_key: true
      t.string :title
      t.text :body
      t.integer :position

      t.timestamps
    end
  end
end
