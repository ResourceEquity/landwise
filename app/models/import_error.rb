# == Schema Information
#
# Table name: import_errors
#
#  id         :bigint           not null, primary key
#  message    :string
#  field      :string
#  line       :integer
#  trace      :text
#  row        :text
#  import_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ImportError < ApplicationRecord

  belongs_to :import, inverse_of: :import_errors

end
