require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'validating presence' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:completion_date) }
  end

  context 'validating uniqueness' do
    it { is_expected.to validates_uniqueness_of(:name) }
  end

  context 'when validating project associations' do
    it { is_expected.to has_many(:artifacts) }
    it { is_expected.to has_many(:tasks) }
    it { is_expected.to has_many(:items) }
    it { is_expected.to has_many(:user_projects) }
  end



end
