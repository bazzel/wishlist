# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDecorator do
  let(:decorator) { described_class.new(user) }
  let(:user)      { create :user, email: 'john.doe@example.org' }

  describe '#mail_to' do
    subject { decorator.mail_to }

    it { is_expected.to eql('john.doe@example.org') }
  end
end
