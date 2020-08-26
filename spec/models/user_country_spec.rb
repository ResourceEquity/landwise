# == Schema Information
#
# Table name: user_countries
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  country_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UserCountry, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
