# == Schema Information
#
# Table name: user_favorites
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  record_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UserFavorite, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
