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

class ItemLanguage < ApplicationRecord
  belongs_to :language
  belongs_to :item
end
