class CreateItemLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :item_languages do |t|
      t.references :language, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps

      t.index [:item_id, :language_id]
      t.index [:language_id, :item_id]
    end
  end
end
