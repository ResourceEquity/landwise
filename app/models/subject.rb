# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subject < ApplicationRecord

  has_many :guide_subjects, dependent: :delete_all

  validates :title, presence: { message: '^Please provide a title for the subject.' }

  alias_attribute :label, :title

end
