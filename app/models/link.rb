class Link < ApplicationRecord

  belongs_to :resource, polymorphic: true

end
