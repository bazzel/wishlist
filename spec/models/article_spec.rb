# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
    it { is_expected.to validate_length_of(:description).is_at_most(1024) }
    it { is_expected.to validate_numericality_of(:price).allow_nil.is_greater_than(0).is_less_than(100_000) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:guest) }
  end
end
