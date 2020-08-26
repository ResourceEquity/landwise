# == Schema Information
#
# Table name: sections
#
#  id         :bigint           not null, primary key
#  article_id :bigint
#  title      :string
#  body       :text
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Section, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
