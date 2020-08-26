# == Schema Information
#
# Table name: imports
#
#  id         :bigint           not null, primary key
#  total      :integer          default(0)
#  complete   :integer          default(0)
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Import < ApplicationRecord

  class DocumentNotValid < StandardError; end

  has_one_attached :import

  has_many :import_errors, inverse_of: :import, dependent: :destroy

  belongs_to :user

  def title
    "#{created_at.strftime('%B %-d, %Y')} / #{import.blob.filename}"
  end

end
