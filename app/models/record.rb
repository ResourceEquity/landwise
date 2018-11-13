# == Schema Information
#
# Table name: records
#
#  id              :bigint(8)        not null, primary key
#  title           :string
#  creator         :string
#  description     :text
#  published       :boolean          default(TRUE)
#  author          :string
#  notes           :string
#  category_id     :bigint(8)
#  jurisdiction_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Record < ApplicationRecord

  belongs_to :category
  belongs_to :jurisdiction

  has_many :record_users,           dependent: :delete_all
  has_many :record_topics,          dependent: :delete_all
  has_many :record_countries,       dependent: :delete_all
  has_many :responsibility_records, dependent: :delete_all
  has_many :user_favorites,         dependent: :delete_all

  has_many :users,            through: :record_users
  has_many :topics,           through: :record_topics
  has_many :countries,        through: :record_countries
  has_many :responsibilities, through: :responsibility_records

  has_many :items, inverse_of: :record

  validates :title, presence: { message: '^Please provide a record title.' }
  validates :creator, presence: { message: '^Please provide a record creator.' }

  after_initialize :assign_admin

  searchable do
    text :title, :creator, :description

    text(:category)      { category.title }
    text(:jurisdiction)  { jurisdiction.title }
    text(:topics)        { topics.map(&:title) }
    text(:countries)     { countries.map(&:title) }
    text(:users)         { users.map(&:name) }

    boolean :published
    time    :updated_at
    time    :created_at

    string(:title_sort, as: :title_sort)        { title }
    string(:category_sort, as: :category_sort)  { category.title }

    integer(:user_ids, multiple: true)     { users.map(&:id) }
    integer(:country_ids, multiple: true)  { countries.map(&:id) }
    integer(:topic_ids, multiple: true)    { topics.map(&:id) }
    integer(:language_ids, multiple: true) { items.map { |item| item.languages.map(&:id) }.flatten.uniq }
    integer(:category_id)                  { category.id }
    integer(:jurisdiction_id)              { jurisdiction.id }

    integer(:roles, multiple: true)        { responsibilities.map(&:id) }
  end

  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  def favorited_by?(user)
    user_favorites.where(user: user).first
  end

  def visible_to?(user)
    if user.present?
      (user.responsibilities & responsibilities).any?
    else
      responsibilities.any? { |r| r.title.parameterize.underscore == 'public' }
    end
  end

  private

    def assign_admin
      responsibilities << Responsibility.find_by(title: 'Admin') unless responsibilities.any? { |r| r.title == 'Admin' }
      responsibilities << Responsibility.find_by(title: 'Public') unless responsibilities.any? { |r| r.title == 'Public' }
    end

end
