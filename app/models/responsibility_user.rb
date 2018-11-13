# == Schema Information
#
# Table name: responsibility_users
#
#  id                :bigint(8)        not null, primary key
#  responsibility_id :bigint(8)
#  user_id           :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ResponsibilityUser < ApplicationRecord
  belongs_to :responsibility
  belongs_to :user
end
