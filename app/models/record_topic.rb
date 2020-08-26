# == Schema Information
#
# Table name: record_topics
#
#  id         :bigint           not null, primary key
#  topic_id   :bigint
#  record_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecordTopic < ApplicationRecord
  belongs_to :topic
  belongs_to :record
end
