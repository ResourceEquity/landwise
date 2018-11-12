# == Schema Information
#
# Table name: items
#
#  id          :bigint(8)        not null, primary key
#  record_id   :bigint(8)
#  title       :string
#  year        :integer
#  description :text
#  url         :string
#  published   :boolean          default(TRUE)
#  restricted  :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
