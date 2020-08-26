# == Schema Information
#
# Table name: responsibility_records
#
#  id                :bigint           not null, primary key
#  responsibility_id :bigint
#  record_id         :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ResponsibilityRecord < ApplicationRecord
  belongs_to :responsibility
  belongs_to :record
end
