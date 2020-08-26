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

class UserCountry < ApplicationRecord
  belongs_to :user
  belongs_to :country
end
