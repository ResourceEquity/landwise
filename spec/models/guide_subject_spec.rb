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

require 'rails_helper'

RSpec.describe GuideSubject, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
