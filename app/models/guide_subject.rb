# == Schema Information
#
# Table name: guide_subjects
#
#  id         :bigint           not null, primary key
#  subject_id :bigint
#  guide_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GuideSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :guide
end
