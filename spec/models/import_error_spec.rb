# == Schema Information
#
# Table name: import_errors
#
#  id         :bigint           not null, primary key
#  message    :string
#  field      :string
#  line       :integer
#  trace      :text
#  row        :text
#  import_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ImportError, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
