# == Schema Information
#
# Table name: guide_countries
#
#  id         :bigint           not null, primary key
#  country_id :bigint
#  guide_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GuideCountry < ApplicationRecord
  belongs_to :country
  belongs_to :guide
end
