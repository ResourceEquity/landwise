class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :record, foreign_key: true
      t.string :title
      t.integer :year
      t.text :description
      t.string :url
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
