# == Schema Information
#
# Table name: responsibility_users
#
#  id                :bigint           not null, primary key
#  responsibility_id :bigint
#  user_id           :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ResponsibilityUser < ApplicationRecord
  belongs_to :responsibility
  belongs_to :user
end
