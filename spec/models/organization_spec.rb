require 'rails_helper'

RSpec.describe Organization, type: :model do
  context 'validating presence' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:subdomain) }
    it { is_expected.to validate_presence_of(:domain) } 
  end
end
