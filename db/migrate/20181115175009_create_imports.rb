class CreateImports < ActiveRecord::Migration[5.2]
  def change
    create_table :imports do |t|
      t.integer :total, default: 0
      t.integer :complete, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
