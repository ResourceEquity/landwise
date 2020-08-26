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

require 'rails_helper'

RSpec.describe UserJurisdiction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
