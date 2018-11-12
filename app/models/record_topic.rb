# == Schema Information
#
# Table name: record_topics
#
#  id         :bigint(8)        not null, primary key
#  topic_id   :bigint(8)
#  record_id  :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecordTopic < ApplicationRecord
  belongs_to :topic
  belongs_to :record
end
