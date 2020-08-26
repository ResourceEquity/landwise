# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Country < ApplicationRecord

  has_many :record_countries, dependent: :delete_all
  has_many :guide_countries,  dependent: :delete_all

  validates :title, presence: { message: '^Please enter a name for the country.' }

  alias_attribute :label, :title

  attr_accessor :count

end
