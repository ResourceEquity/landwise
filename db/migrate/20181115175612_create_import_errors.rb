class CreateImportErrors < ActiveRecord::Migration[5.2]
  def change
    create_table :import_errors do |t|
      t.string :message
      t.string :field
      t.integer :line
      t.text :trace
      t.text :row
      t.references :import, foreign_key: true

      t.timestamps
    end
  end
end
