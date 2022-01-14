require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is not valid without email' do
    user1 = described_class.new(email: nil)
    expect(user1).not_to be_valid
  end

  it 'is not valid without password' do
    user1 = described_class.new(encrypted_password: nil)
    expect(user1).not_to be_valid
  end

  it 'is not valid without type' do
    user1 = described_class.new(type: nil)
    expect(user1).not_to be_valid
  end
end
