# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  subject     { described_class.new(user, event) }

  let(:event) { create(:event, users: [me]) }
  let(:me)    { build :user }
  let(:you)   { build :user }

  context 'with me' do
    let(:user) { me }

    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    # it { is_expected.to permit_action(:update) }
    # it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:show) }
  end

  context 'with you' do
    let(:user) { you }

    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    # it { is_expected.to permit_action(:update) }
    # it { is_expected.to permit_action(:destroy) }
    it { is_expected.to forbid_action(:show) }
  end
end
