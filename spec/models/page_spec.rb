# == Schema Information
#
# Table name: pages
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  show_in_menu :boolean          default(FALSE)
#  body         :text
#  keywords     :string
#  description  :string
#  slug         :string
#  position     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Page, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
