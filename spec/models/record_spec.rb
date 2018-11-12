# == Schema Information
#
# Table name: records
#
#  id              :bigint(8)        not null, primary key
#  title           :string
#  creator         :string
#  description     :text
#  published       :boolean          default(TRUE)
#  author          :string
#  notes           :string
#  flagged         :boolean          default(FALSE)
#  category_id     :bigint(8)
#  jurisdiction_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Record, type: :model do

end
