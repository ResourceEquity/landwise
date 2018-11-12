# == Schema Information
#
# Table name: items
#
#  id          :bigint(8)        not null, primary key
#  record_id   :bigint(8)
#  title       :string
#  year        :integer
#  description :text
#  url         :string
#  published   :boolean          default(TRUE)
#  restricted  :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Item < ApplicationRecord

  belongs_to :record, inverse_of: :items

  has_many :item_languages, dependent: :delete_all

  has_many :languages, through: :item_languages

  has_one_attached :document

  validates :title, presence: { message: '^Please enter an item title.' }
  validates :year, numericality: { message: '^Please enter a valid 4-digit year.', allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }

end
