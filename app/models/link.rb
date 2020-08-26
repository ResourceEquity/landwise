# == Schema Information
#
# Table name: links
#
#  id            :bigint           not null, primary key
#  url           :string
#  code          :integer
#  stdout        :text
#  stderr        :text
#  resource_type :string
#  resource_id   :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Link < ApplicationRecord

  belongs_to :resource, polymorphic: true

end
