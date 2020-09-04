# == Schema Information
#
# Table name: records
#
#  id              :bigint           not null, primary key
#  title           :string
#  creator         :string
#  description     :text
#  published       :boolean          default(TRUE)
#  author          :string
#  notes           :string
#  category_id     :bigint
#  jurisdiction_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Record, type: :model do

  let!(:record) { create(:record) }

  before do
    2.times do
      record.links << build(:link, :invalid)
    end
  end

  it 'clears the links when the description is updated' do
    expect { record.update(description: 'Hello World') }.to change(record.links, :count).by(-2)
  end

end
