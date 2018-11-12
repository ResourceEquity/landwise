class CreateUserTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :user_topics do |t|
      t.references :user, foreign_key: true
      t.references :topic, foreign_key: true

      t.timestamps

      t.index [:topic_id, :user_id]
      t.index [:user_id, :topic_id]
    end
  end
end
