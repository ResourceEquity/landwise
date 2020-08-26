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

require 'rails_helper'

RSpec.describe RecordTopic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
