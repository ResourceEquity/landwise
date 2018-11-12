# == Schema Information
#
# Table name: guide_subjects
#
#  id         :bigint(8)        not null, primary key
#  subject_id :bigint(8)
#  guide_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GuideSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :guide
end
