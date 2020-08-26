# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  record_id   :bigint
#  title       :string
#  year        :integer
#  description :text
#  url         :string
#  position    :integer
#  published   :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
