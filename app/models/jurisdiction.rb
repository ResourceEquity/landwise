# == Schema Information
#
# Table name: jurisdictions
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Jurisdiction < ApplicationRecord

  validates :title, presence: { message: '^Please provide a title for the jurisdiction.' }

  alias_attribute :label, :title

  attr_accessor :count
  
end
