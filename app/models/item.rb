# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  record_id   :bigint
#  title       :string
#  year        :integer
#  description :text
#  url         :string
#  position    :integer
#  published   :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Item < ApplicationRecord

  LINK_FIELDS = [:url, :description]

  belongs_to :record, inverse_of: :items

  has_many :item_languages, dependent: :delete_all
  has_many :languages, through: :item_languages
  has_many :links, as: :resource

  has_one_attached :document

  after_create :scan

  after_save :clear_links, if: :links_updated?

  validates :title, presence: { message: '^Please enter an item title.' }
  validates :year, numericality: { message: '^Please enter a valid 4-digit year.', allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }

  default_scope { order(position: :asc) }

  def scan(delay = 1.week)
    ScanJob.set(wait: delay).perform_later(self)
  end

  def admin_path
    Rails.application.routes.url_helpers.edit_admin_record_path(record)
  end

  private

    def links_updated?
      LINK_FIELDS.any? { |field| send("saved_change_to_#{field}?") }
    end

    def clear_links
      links.destroy_all
    end

end
