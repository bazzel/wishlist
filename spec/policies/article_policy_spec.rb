# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlePolicy, type: :policy do
  subject       { described_class.new(user, article) }

  before        { event.users << you }

  let(:event)   { article.event }
  let(:me)      { article.user }
  let(:you)     { build :user }
  let(:article) { create(:article) }

  context 'with me' do
    let(:user) { me }

    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    # it { is_expected.to permit_action(:show) }
  end

  context 'with you' do
    let(:user) { you }

    it { is_expected.to permit_action(:new) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_action(:update) }
    # it { is_expected.to permit_action(:show) }
  end
end
