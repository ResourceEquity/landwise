class CreateSubguides < ActiveRecord::Migration[4.2]
  def change
    create_table :subguides do |t|
      # Ripit
      # t.text :body
      t.string :title
      # Ripit
      # t.references :guide

      t.timestamps
    end
  end
end