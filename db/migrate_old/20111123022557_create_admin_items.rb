class CreateAdminItems < ActiveRecord::Migration[4.2]
  def change
    create_table :items do |t|
      t.string :title
      t.text :excerpt
      t.text :description
      t.string :url
      t.string :jurisdiction
      t.date :publication_date
      t.boolean :published, :default => true
      t.boolean :restricted, :default => false
      t.string :item_file_name
      t.string :item_content_type
      t.integer :item_file_size
      t.datetime :item_updated_at
      t.integer :record_id
      t.integer :user_id
      t.integer :item_language_id

      t.timestamps
    end
  end
end
