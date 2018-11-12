class CreateTableItemLanguagesItems < ActiveRecord::Migration[4.2]
  def up
  	create_table :item_languages_items do |t|
  		t.integer :item_language_id
  		t.integer :item_id
  	end
  end

  def down
  	drop_table :item_languages_items
  end
end
