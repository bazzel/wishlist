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

  describe '#invited?' do
    subject        { instance.invited?(user) }

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

  describe '#guest_emails=' do
    let(:instance) { build :event }

    context 'with stringified JSON' do
      context 'with existing users' do
        let!(:user) { create :user }

        it 'adds the users as guests' do
          instance.guest_emails = [{ value: user.email }].to_json
          instance.validate
          expect(instance.users.size).to be(1)
        end
      end

      context 'with non-existing users' do
        it 'adds the users as guests' do
          instance.guest_emails = [{ value: 'jane.doe@example.org' }].to_json
          instance.validate
          expect(instance.users.size).to be(1)
        end
      end

      context 'with invalid e-mailadresses' do
        it 'invalidates the event' do
          instance.guest_emails = [{ value: 'jane.doe' }].to_json
          expect(instance).not_to be_valid
        end

        it 'adds an error to `guest_emails`' do
          instance.guest_emails = [{ value: 'jane.doe' }].to_json
          instance.validate
          expect(instance.errors[:guest_emails]).not_to be_empty
        end
      end
    end

    context 'with an array of strings' do
      it 'adds the users as guests' do
        instance.guest_emails = 'jane.doe@example.org'
        instance.validate
        expect(instance.users.size).to be(1)
      end
    end
  end
end
