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

class UserFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :record
end
