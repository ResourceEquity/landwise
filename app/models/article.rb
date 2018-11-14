# == Schema Information
#
# Table name: articles
#
#  id         :bigint(8)        not null, primary key
#  guide_id   :bigint(8)
#  title      :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ApplicationRecord

  belongs_to :guide, inverse_of: :articles

  has_many :sections, inverse_of: :article, dependent: :destroy

  validates :title, presence: { message: '^Please provide a title for each article.' }

  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true

  default_scope { order(position: :asc) }

  def prev
    idx = options.index { |article| article.id == id }
    idx.zero? ? nil : options[idx - 1]
  end

  def next
    idx = options.index { |article| article.id == id }
    idx == options.length - 1 ? nil : options[idx + 1]
  end

  private

    def options
      @options ||= guide.articles.to_a
    end

end
