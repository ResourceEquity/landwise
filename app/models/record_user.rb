# == Schema Information
#
# Table name: record_users
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  record_id  :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecordUser < ApplicationRecord
  belongs_to :user
  belongs_to :record
end
