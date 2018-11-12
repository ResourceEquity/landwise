# == Schema Information
#
# Table name: guide_users
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  guide_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GuideUser < ApplicationRecord
  belongs_to :user
  belongs_to :guide
end
