require 'rails_helper'

RSpec.describe ScanJob, type: :job do
  
  let!(:record) { create(:record, description: 'Hello World https://thissitedoesnotexistinanyform.missing') }

  before do
    Responsibility.create(title: 'Admin')
    Responsibility.create(title: 'Public')
  end

  it 'locates and scans links in the description field' do
    expect { described_class.perform_now(record) }.to change(Link, :count).by(1)
  end

end
