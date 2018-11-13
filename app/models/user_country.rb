# == Schema Information
#
# Table name: user_countries
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  country_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserCountry < ApplicationRecord
  belongs_to :user
  belongs_to :country
end
