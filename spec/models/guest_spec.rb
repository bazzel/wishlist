# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:articles).dependent(:destroy) }

    it { is_expected.to have_many(:claims).class_name('Article').with_foreign_key('claimant_id').dependent(:nullify).inverse_of(:claimant) }
  end

  it { is_expected.to delegate_method(:email).to(:user) }
end
