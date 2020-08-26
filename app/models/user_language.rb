# == Schema Information
#
# Table name: user_languages
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  language_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserLanguage < ApplicationRecord
  belongs_to :user
  belongs_to :language
end
