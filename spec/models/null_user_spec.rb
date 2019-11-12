# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NullUser, type: :model do
  it { is_expected.to be_anonymous }

  describe 'attributes' do
    let(:instance) { described_class.new }

    describe '#id' do
      subject { instance.id }

      it      { is_expected.to be_nil }
    end
  end
end
