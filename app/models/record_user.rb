# == Schema Information
#
# Table name: record_users
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  record_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecordUser < ApplicationRecord
  belongs_to :user
  belongs_to :record
end
