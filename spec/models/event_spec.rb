# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:guests).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:guests) }
  end

  describe 'scopes' do
    describe '.with_user' do
      subject         { described_class.with_user(me) }

      before          { create(:event, users: [you]) }

      let!(:my_event) { create(:event, users: [me]) }
      let(:me)        { create(:user) }
      let(:you)       { create(:user) }

      it { is_expected.to contain_exactly(my_event) }
    end
  end

  describe '#slug' do
    subject(:instance) { create :event }

    it { expect(instance.slug).not_to be_nil }
  end

  describe '#has_user?' do
    subject        { instance.has_user?(user) }

    let(:instance) { create(:event, users: [me]) }
    let(:me)       { create(:user) }
    let!(:you)     { create(:user) }

    context 'with user' do
      let(:user) { me }

      it { is_expected.to be true }
    end

    context 'without user' do
      let(:user) { you }

      it { is_expected.to be false }
    end
  end
end
