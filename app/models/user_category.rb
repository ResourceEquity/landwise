# == Schema Information
#
# Table name: user_categories
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  category_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category
end
