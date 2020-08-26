# == Schema Information
#
# Table name: guide_users
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  guide_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GuideUser < ApplicationRecord
  belongs_to :user
  belongs_to :guide
end
