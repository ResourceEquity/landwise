class CreateResponsibilities < ActiveRecord::Migration[5.2]
  def change
    create_table :responsibilities do |t|
      t.string :title
      t.boolean :locked, default: false

      t.timestamps
    end
  end
end
