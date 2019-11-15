# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
  end

  describe '#slug' do
    subject(:instance) { create :event }

    it do
      expect(instance.slug).not_to be_nil
    end
  end
end
