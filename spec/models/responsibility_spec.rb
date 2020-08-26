# == Schema Information
#
# Table name: responsibilities
#
#  id         :bigint           not null, primary key
#  title      :string
#  locked     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Responsibility, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
