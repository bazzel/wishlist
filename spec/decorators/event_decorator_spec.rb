# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventDecorator do
  let(:decorator) { described_class.new(event) }

  describe '#number_of_users' do
    subject { decorator.number_of_users }

    context 'with one user' do
      let(:event) { create :event, users_count: 1 }

      it { is_expected.to eql('1 gast') }
    end

    context 'with many user' do
      let(:event) { create :event, users_count: 2 }

      it { is_expected.to eql('2 gasten') }
    end
  end
end
