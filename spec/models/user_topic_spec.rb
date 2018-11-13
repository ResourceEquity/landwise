# == Schema Information
#
# Table name: user_topics
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  topic_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UserTopic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
