# == Schema Information
#
# Table name: topics
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ApplicationRecord

  has_many :record_topics, dependent: :delete_all

  validates :title, presence: { message: '^Please provide a title for the topic.' }

  alias_attribute :label, :title

end
