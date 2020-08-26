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

require 'rails_helper'

RSpec.describe GuideSubject, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
