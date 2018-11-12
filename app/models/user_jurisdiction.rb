class UserJurisdiction < ApplicationRecord
  belongs_to :user
  belongs_to :jurisdiction
end
