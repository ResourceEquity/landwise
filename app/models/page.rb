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

class Page < ApplicationRecord

  validates :title, presence:         { message: '^Please specify a page title.' }
  validates :position, numericality:  { message: '^Menu position must be a whole number greater than or equal to zero.', allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }
  validates :slug, presence:          { message: '^Please specify a page slug.' },
                   format:            { message: '^Page slugs must be lowercase and contain only letters, numbers, and dashes.', with: /\A[a-z0-9\-]+\z/ }

end
