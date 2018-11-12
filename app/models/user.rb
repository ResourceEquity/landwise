# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  contact                :string
#  title                  :string
#  author                 :boolean          default(FALSE)
#  bio                    :text
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ApplicationRecord

  rolify

  notifyable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :record_users,         dependent: :delete_all
  has_many :responsibility_users, dependent: :delete_all
  has_many :user_topics,          dependent: :delete_all
  has_many :user_countries,       dependent: :delete_all
  has_many :user_languages,       dependent: :delete_all
  has_many :user_categories,      dependent: :delete_all
  has_many :user_jurisdictions,   dependent: :delete_all
  has_many :user_favorites,       dependent: :delete_all

  has_many :records,          through: :record_users
  has_many :responsibilities, through: :responsibility_users
  has_many :topics,           through: :user_topics
  has_many :countries,        through: :user_countries
  has_many :languages,        through: :user_languages
  has_many :categories,       through: :user_categories
  has_many :jurisdictions,    through: :user_jurisdictions
  has_many :favorites,        through: :user_favorites, class_name: 'Record', foreign_key: 'record_id'

  has_one_attached :avatar

  before_create :assign_public

  scope :authors, -> { where(author: true) }

  validates :first_name, :last_name, presence: true

  enum notification_interval: [:never, :weekly, :monthly]

  searchable do
    text :first_name, :last_name, :email, :title
  end

  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    responsibilities.any? { |r| r.title.parameterize.underscore == 'admin' }
  end

  alias_attribute :label, :name

  private

    def assign_public
      responsibilities << Responsibility.find_by(title: 'Public')
    end

end
