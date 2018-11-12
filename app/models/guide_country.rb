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

class GuideCountry < ApplicationRecord
  belongs_to :country
  belongs_to :guide
end
