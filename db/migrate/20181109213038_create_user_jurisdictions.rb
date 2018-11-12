class CreateUserJurisdictions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_jurisdictions do |t|
      t.references :user, foreign_key: true
      t.references :jurisdiction, foreign_key: true

      t.timestamps

      t.index [:jurisdiction_id, :user_id]
      t.index [:user_id, :jurisdiction_id]
    end
  end
end
