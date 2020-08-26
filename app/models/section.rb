# == Schema Information
#
# Table name: sections
#
#  id         :bigint           not null, primary key
#  article_id :bigint
#  title      :string
#  body       :text
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Section < ApplicationRecord

  LINK_FIELDS = [:body]

  belongs_to :article, inverse_of: :sections, touch: true

  has_many :links, as: :resource

  after_create :scan

  validates :title, presence: { message: '^Please provide a title for each article section.' }

  default_scope { order(position: :asc) }

  def scan(delay = 1.week)
    ScanJob.set(wait: delay).perform_later(self)
  end

  def admin_path
    Rails.application.routes.url_helpers.edit_admin_guide_path(article.guide)
  end

  def html
    doc = Nokogiri::HTML(body)
    # doc.xpath('//@style').remove
    doc.css('p').find_all { |node| node.name != 'br' && node.content.strip.blank? }.each(&:remove)
    doc.css('body').map(&:inner_html).join.html_safe
  end

end
