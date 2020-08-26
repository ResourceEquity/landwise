# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord

  validates :title, presence: { message: '^Please provide a title for the collection type.' }

  alias_attribute :label, :title

  attr_accessor :count

end
