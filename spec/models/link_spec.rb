# == Schema Information
#
# Table name: links
#
#  id            :bigint           not null, primary key
#  url           :string
#  code          :integer
#  stdout        :text
#  stderr        :text
#  resource_type :string
#  resource_id   :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Link, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
