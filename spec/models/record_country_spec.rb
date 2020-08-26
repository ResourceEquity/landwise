# == Schema Information
#
# Table name: record_countries
#
#  id         :bigint           not null, primary key
#  country_id :bigint
#  record_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe RecordCountry, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
