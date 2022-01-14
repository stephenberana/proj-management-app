require 'rails_helper'

RSpec.describe Artifact, type: :model do
  context 'when validating artifact associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to has_many(:tasks) }
  end

  context 'validating presence' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'validating uniqueness' do
    it { is_expected.to validates_uniqueness_of(:name) }
  end
end
