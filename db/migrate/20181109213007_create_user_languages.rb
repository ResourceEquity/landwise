class CreateUserLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :user_languages do |t|
      t.references :user, foreign_key: true
      t.references :language, foreign_key: true

      t.timestamps

      t.index [:language_id, :user_id]
      t.index [:user_id, :language_id]
    end
  end
end
