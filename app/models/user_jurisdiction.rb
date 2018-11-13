# == Schema Information
#
# Table name: user_jurisdictions
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)
#  jurisdiction_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UserJurisdiction < ApplicationRecord
  belongs_to :user
  belongs_to :jurisdiction
end
