class Responsibility < ApplicationRecord

  has_many :responsibility_users,   dependent: :delete_all
  has_many :responsibility_records, dependent: :delete_all

  has_many :users,   through: :responsibility_users
  has_many :records, through: :responsibility_records

  before_destroy :protect_locked, prepend: true

  validates :title, presence: { message: '^Please enter a role name.' }
  validates :title, uniqueness: { message: '^Role names must be unique.', case_sensitive: false }

  private

    def protect_locked
      self.errors.add :base, 'You are not permitted to destroy a locked role.'
      throw :abort
    end

end
