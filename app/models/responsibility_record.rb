# == Schema Information
#
# Table name: responsibility_records
#
#  id                :bigint(8)        not null, primary key
#  responsibility_id :bigint(8)
#  record_id         :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ResponsibilityRecord < ApplicationRecord
  belongs_to :responsibility
  belongs_to :record
end
