class CreateRecordTopics < ActiveRecord::Migration[4.2]
  def change
    create_table :record_topics do |t|
      t.string :name
      t.integer :parent_id
    end
    
    create_table :record_topics_records, id: false do |t|
      t.integer :record_id
      t.integer :record_topic_id
    end
  end
end
