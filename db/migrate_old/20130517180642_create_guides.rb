class CreateGuides < ActiveRecord::Migration[4.2]
  def change
    create_table :guides do |t|
      t.string :title, :null => false
      t.references :author, :null => false
      t.references :subject, :null => false
      t.references :subguides

      t.timestamps
    end
    add_index :guides, :author_id
    add_index :guides, :subject_id
    add_index :guides, :subguides_id
  end
end