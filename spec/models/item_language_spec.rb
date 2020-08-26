# == Schema Information
#
# Table name: item_languages
#
#  id          :bigint           not null, primary key
#  language_id :bigint
#  item_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe ItemLanguage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
