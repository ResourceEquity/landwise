# == Schema Information
#
# Table name: sections
#
#  id         :bigint(8)        not null, primary key
#  article_id :bigint(8)
#  title      :string
#  body       :text
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Section < ApplicationRecord

  belongs_to :article, inverse_of: :sections

  validates :title, presence: { message: '^Please provide a title for each article section.' }

  default_scope { order(position: :asc) }

  def html
    doc = Nokogiri::HTML(body)
    doc.xpath('//@style').remove
    doc.css('p').find_all { |node| node.name != 'br' && node.content.strip.blank? }.each(&:remove)
    doc.css('body').map(&:inner_html).join.html_safe
  end

end
