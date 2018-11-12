class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.string :title
      t.string :creator
      t.text :description
      t.boolean :published, default: true
      t.string :author
      t.string :notes
      t.references :category, foreign_key: true
      t.references :jurisdiction, foreign_key: true

      t.timestamps
    end
  end
end
