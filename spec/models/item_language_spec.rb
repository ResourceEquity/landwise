# == Schema Information
#
# Table name: item_languages
#
#  id          :bigint(8)        not null, primary key
#  language_id :bigint(8)
#  item_id     :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe ItemLanguage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
