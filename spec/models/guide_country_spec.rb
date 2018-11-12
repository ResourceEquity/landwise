# == Schema Information
#
# Table name: guide_countries
#
#  id         :bigint(8)        not null, primary key
#  country_id :bigint(8)
#  guide_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe GuideCountry, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
