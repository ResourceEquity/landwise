class CreateRecordUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :record_users do |t|
      t.references :user, foreign_key: true
      t.references :record, foreign_key: true

      t.timestamps

      t.index [:record_id, :user_id]
      t.index [:user_id, :record_id]
    end
  end
end
