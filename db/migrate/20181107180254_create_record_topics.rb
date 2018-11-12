class CreateRecordTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :record_topics do |t|
      t.references :topic, foreign_key: true
      t.references :record, foreign_key: true

      t.timestamps

      t.index [:record_id, :topic_id]
      t.index [:topic_id, :record_id]
    end
  end
end
