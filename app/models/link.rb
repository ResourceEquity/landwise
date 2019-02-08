class Link < ApplicationRecord

  belongs_to :resource, polymorphic: true, touch: true

end
