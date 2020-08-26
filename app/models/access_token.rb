# == Schema Information
#
# Table name: access_tokens
#
#  id         :bigint           not null, primary key
#  name       :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AccessToken < ApplicationRecord

  has_secure_token :token

  belongs_to :user

  validates_presence_of :title
  validates_uniqueness_of :token

end
