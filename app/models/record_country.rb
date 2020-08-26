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

class RecordCountry < ApplicationRecord
  belongs_to :country
  belongs_to :record
end
