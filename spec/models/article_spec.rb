# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
    it { is_expected.to validate_length_of(:description).is_at_most(1024) }
    it { is_expected.to validate_numericality_of(:price).allow_nil.is_greater_than(0).is_less_than(100_000) }

    it { is_expected.to belong_to(:claimant).class_name('Guest').with_foreign_key('claimant_id').optional.inverse_of(:claims) }
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:stores) }
    it { is_expected.to belong_to(:guest) }
  end

  describe 'delegation' do
    subject(:instance) { create :article }

    it { expect(instance.event).to eql(instance.guest.event) }
    it { expect(instance.user).to eql(instance.guest.user) }
  end

  describe '#slug' do
    subject(:instance) { create :article }

    it { expect(instance.slug).not_to be_nil }
  end

  describe '#store_names=' do
    let(:instance) { build :article }

    context 'with stringified JSON' do
      context 'with existing stores' do
        let!(:store) { create :store }

        it 'adds the store' do
          instance.store_names = [{ value: store.name }].to_json
          instance.validate
          expect(instance.stores.size).to be(1)
        end
      end

      context 'with non-existing stores' do
        it 'adds the store' do
          instance.store_names = [{ value: 'Hema' }].to_json
          instance.validate
          expect(instance.stores.size).to be(1)
        end
      end

      context 'with invalid names' do
        it 'invalidates the article' do
          instance.store_names = [{ value: '' }].to_json
          expect(instance).not_to be_valid
        end

        it 'adds an error to `store_names`' do
          instance.store_names = [{ value: '' }].to_json
          instance.validate
          expect(instance.errors[:store_names]).not_to be_empty
        end
      end
    end

    context 'with a strings' do
      it 'adds the store' do
        instance.store_names = 'Hema, Blokker'
        instance.validate
        expect(instance.stores.size).to be(2)
      end
    end
  end

  describe '#claim' do
    subject(:claim) { instance.claim(claimant) }

    let(:instance) { create :article }
    let(:claimant) { create(:guest, event: instance.event) }

    it do
      expect { claim }.to change(instance, :claimant).from(nil).to(claimant)
    end
  end

  describe '#disclaim' do
    subject(:disclaim) { instance.disclaim }

    before         { instance.claim(claimant) }

    let(:instance) { create :article }
    let(:claimant) { create(:guest, event: instance.event) }

    it do
      expect { disclaim }.to change(instance, :claimant).from(claimant).to(nil)
    end
  end
end
