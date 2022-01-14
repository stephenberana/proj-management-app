require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'when validating artifact associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to belong_to(:task) }
  end

  context 'validating presence' do
    it { is_expected.to validate_presence_of(:name) }
  end

end
