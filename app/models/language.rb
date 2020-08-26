# == Schema Information
#
# Table name: languages
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Language < ApplicationRecord

  has_many :item_languages, dependent: :delete_all

  validates :title, presence: { message: '^Please provide a language name.' }

  alias_attribute :label, :title

  attr_accessor :count

end
