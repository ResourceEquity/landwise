class CreateGuideUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :guide_users do |t|
      t.references :user, foreign_key: true
      t.references :guide, foreign_key: true

      t.timestamps

      t.index [:guide_id, :user_id]
      t.index [:user_id, :guide_id]
    end
  end
end
