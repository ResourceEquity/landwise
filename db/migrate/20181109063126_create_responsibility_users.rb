class CreateResponsibilityUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :responsibility_users do |t|
      t.references :responsibility, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps

      t.index [:responsibility_id, :user_id]
      t.index [:user_id, :responsibility_id]
    end
  end
end
