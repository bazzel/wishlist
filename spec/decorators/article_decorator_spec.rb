# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticleDecorator do
  let(:decorator) { described_class.new(article) }

  describe '#claimed?' do
    subject         { decorator.claimed? }

    before          { allow(h).to receive(:current_user).and_return(current_user) }

    let(:article)   { create :article }
    let(:me_user)   { article.guest.user }
    let(:you_guest) { create(:guest, event: article.event) }
    let(:you_user)  { you_guest.user }

    context 'when not claimed' do
      context 'when I view my article' do
        let(:current_user) { me_user }

        it { is_expected.to be_falsy }
      end

      context 'when other view my article' do
        let(:current_user) { you_user }

        it { is_expected.to be_falsy }
      end
    end

    context 'when claimed' do
      before        { article.claim(you_guest) }

      let(:he_user) { create(:guest, event: article.event).user }

      context 'when I view my article' do
        let(:current_user) { me_user }

        it                 { is_expected.to be_falsy }
      end

      context 'when you view my article' do
        let(:current_user) { you_user }

        it { is_expected.to be_truthy }
      end

      context 'when he views my article' do
        let(:current_user) { he_user }

        it { is_expected.to be_truthy }
      end
    end
  end

  describe '#link_to_claim_or_disclaim' do
    before            { allow(h).to receive(:current_user).and_return(current_user) }

    let(:html)      { decorator.link_to_claim_or_disclaim }
    let(:article)   { create :article }
    let(:me_user)   { article.guest.user }
    let(:you_guest) { create(:guest, event: article.event) }
    let(:you_user)  { you_guest.user }

    context 'when not claimed' do
      context 'when I view my article' do
        subject            { html }

        let(:current_user) { me_user }

        it                 { is_expected.to be_nil }
      end

      context 'when other view my article' do
        subject           { Capybara.string html }

        let(:current_user) { you_user }

        it { is_expected.to have_css('a.btn-float.btn-sm.shadow-none[href$="/claim"][data-method="post"][role="button"]') }
        it { is_expected.to have_css('a i.fas.fa-thumbtack', text: nil) }
      end
    end

    context 'when claimed' do
      let(:he_user) { create(:guest, event: article.event).user }

      before        { article.claim(you_guest) }

      context 'when I view my article' do
        subject            { html }

        let(:current_user) { me_user }

        it                 { is_expected.to be_nil }
      end

      context 'when you view my article' do
        subject            { Capybara.string html }

        let(:current_user) { you_user }

        it { is_expected.to have_css('a.btn-float.btn-sm.shadow-none[href$="/disclaim"][data-method="delete"][role="button"]') }
        it { is_expected.to have_css('a i.fas.fa-thumbtack', text: nil) }
      end

      context 'when he views my article' do
        subject            { html }

        let(:current_user) { he_user }

        it                 { is_expected.to be_nil }
      end
    end
  end
end
