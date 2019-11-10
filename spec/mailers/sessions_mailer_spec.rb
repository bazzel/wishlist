# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsMailer, type: :mailer do
  describe 'magic_link' do
    let(:mail) { described_class.magic_link(user) }
    let(:user) { create(:user, email: 'john.doe@example.org') }

    describe 'headers' do
      it do
        expect(mail.subject).to eq('john.doe@example.org, welkom bij Wishlist!')
      end

      it do
        expect(mail.to).to eq(['john.doe@example.org'])
      end

      it do
        expect(mail.from).to eq(['info@wishlist.com'])
      end
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('welkom bij Wishlist')
    end
  end
end
