# == Schema Information
#
# Table name: redirects
#
#  id         :bigint           not null, primary key
#  from       :string
#  to         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Redirect < ApplicationRecord

  validates :from, presence:   { message: '^Path to redirect from is required.' },
                   format:     { message: '^Redirect from path must begin with a "/"', with: /\A\/.*\z/ },
                   uniqueness: { message: '^Redirect from path must be unique.' }

  validates :to, presence:     { message: '^Please specify a path or url to redirect to.' },
                   format:     { message: '^Redirect to must begin with "http://" or "https://" or be a relative path starting with "/" (e.g. "/records/1")', with: /(^https?:\/\/)|(^\/.*)/ }

end
