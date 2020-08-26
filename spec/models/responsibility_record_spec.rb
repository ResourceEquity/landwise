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

require 'rails_helper'

RSpec.describe ResponsibilityRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
