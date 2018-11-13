# == Schema Information
#
# Table name: user_categories
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)
#  category_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category
end
