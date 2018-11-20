class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :url
      t.integer :code
      t.text :stdout
      t.text :stderr
      t.references :resource, polymorphic: true

      t.timestamps
    end
  end
end
