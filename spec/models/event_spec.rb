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
    it { is_expected.to have_many(:articles).through(:guests) }
    it { is_expected.to have_many(:stores).through(:articles) }
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
          expect(instance.guests.size).to be(1)
        end
      end

      context 'with non-existing users' do
        it 'adds the users as guests' do
          instance.guest_emails = [{ value: 'jane.doe@example.org' }].to_json
          instance.validate
          expect(instance.guests.size).to be(1)
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

    context 'with a string' do
      it 'adds the users as guests' do
        instance.guest_emails = 'jane.doe@example.org, marty@example.org'
        instance.validate
        expect(instance.guests.size).to be(2)
      end
    end
  end

  describe '#store_names' do
    subject(:store_names) { instance.store_names }

    before do
      me_guest = instance.guests.create(user: me)
      me_guest.articles.create(title: 'Lorem', stores: [hema, blokker])
      me_guest.articles.create(title: 'Ipsum', stores: [blokker])

      you_guest = instance.guests.create(user: you)
      you_guest.articles.create(title: 'Lorem', stores: [wibra, blokker])
      you_guest.articles.create(title: 'Ipsum', stores: [hema])
    end

    let(:instance) { create(:event, users: [me]) }
    let(:me)       { create(:user) }
    let!(:you)     { create(:user) }
    let(:hema)     { create(:store, name: 'HEMA') }
    let(:blokker)  { create(:store, name: 'Blokker') }
    let(:wibra)    { create(:store, name: 'Wibra') }
    let(:zeeman)   { create(:store, name: 'Zeeman') }

    it 'returns an array of stores references by articles listed in the event' do
      expect(store_names).to contain_exactly('HEMA', 'Blokker', 'Wibra')
    end
  end
end
