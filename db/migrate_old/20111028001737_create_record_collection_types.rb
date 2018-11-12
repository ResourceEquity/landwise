class CreateRecordCollectionTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :record_collection_types do |t|
      t.string :name
    end
  end
end
