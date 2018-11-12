# == Schema Information
#
# Table name: record_countries
#
#  id         :bigint(8)        not null, primary key
#  country_id :bigint(8)
#  record_id  :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecordCountry < ApplicationRecord
  belongs_to :country
  belongs_to :record
end
