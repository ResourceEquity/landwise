# == Schema Information
#
# Table name: records
#
#  id              :bigint           not null, primary key
#  title           :string
#  creator         :string
#  description     :text
#  published       :boolean          default(TRUE)
#  author          :string
#  notes           :string
#  category_id     :bigint
#  jurisdiction_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Record, type: :model do

end
