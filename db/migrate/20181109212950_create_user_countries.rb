class CreateUserCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :user_countries do |t|
      t.references :user, foreign_key: true
      t.references :country, foreign_key: true

      t.timestamps

      t.index [:country_id, :user_id]
      t.index [:user_id, :country_id]
    end
  end
end
