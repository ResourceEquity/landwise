# == Schema Information
#
# Table name: imports
#
#  id         :bigint           not null, primary key
#  total      :integer          default(0)
#  complete   :integer          default(0)
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Import, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
