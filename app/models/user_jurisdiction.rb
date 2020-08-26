# == Schema Information
#
# Table name: user_jurisdictions
#
#  id              :bigint           not null, primary key
#  user_id         :bigint
#  jurisdiction_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UserJurisdiction < ApplicationRecord
  belongs_to :user
  belongs_to :jurisdiction
end
