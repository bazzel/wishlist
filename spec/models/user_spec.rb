# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it do
      expect(build(:user, email: 'invalid')).to be_invalid
    end
  end

  describe '#invalidate_user' do
    let(:instance) { create :user }

    it do
      expect do
        instance.invalidate_token
      end.to change(instance, :login_token).to(nil).and \
        change(instance, :login_token)
    end
  end

  describe '.with_valid_token' do
    subject        { described_class.valid_with_token(instance.login_token) }

    let(:instance) { create :user }

    context 'with existing user' do
      it { is_expected.to eql(instance) }
    end

    context 'with unknown token' do
      subject { described_class.valid_with_token('unknown-token') }

      it { is_expected.to be_nil }
    end

    context 'with expired token' do
      let(:instance) { create :user, :expired_token }

      it { is_expected.to be_nil }
    end
  end
end
