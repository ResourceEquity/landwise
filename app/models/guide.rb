# == Schema Information
#
# Table name: guides
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  published  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Guide < ApplicationRecord

  include Rails.application.routes.url_helpers

  has_many :guide_users,     dependent: :delete_all
  has_many :guide_subjects,  dependent: :delete_all
  has_many :guide_countries, dependent: :delete_all

  has_many :users,     through: :guide_users
  has_many :subjects,  through: :guide_subjects
  has_many :countries, through: :guide_countries

  has_many :articles, inverse_of: :guide, dependent: :destroy

  accepts_nested_attributes_for :articles,  reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :users,     reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :subjects,  reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :countries, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: { message: '^Please enter a guide title.' }

  searchable do
    text    :title
    time    :updated_at
    boolean :published

    string(:title_sort, as: :title_sort)   { title.downcase }

    integer(:user_ids, multiple: true)     { users.map(&:id) }
    integer(:subject_ids, multiple: true)  { subjects.map(&:id) }
    integer(:country_ids, multiple: true)  { countries.map(&:id) }
  end

  def to_param
    "#{id}-#{title.parameterize.truncate(80, omission: '')}"
  end

  def to_pdf
    tmp = Tempfile.new([id.to_s, '.pdf'], Rails.root.join('tmp'))
    system "chrome-headless-render-pdf --url=#{pdf_url} --pdf=#{tmp.path} --include-background --window-size 1920x1080"
    tmp.read
  end

  private

    def pdf_url
      guide_url(self, format: [:view])
    end

end
