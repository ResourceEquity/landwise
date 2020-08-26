# == Schema Information
#
# Table name: user_topics
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  topic_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserTopic < ApplicationRecord
  belongs_to :user
  belongs_to :topic
end
