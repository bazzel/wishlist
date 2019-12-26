# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventDecorator do
  let(:decorator) { described_class.new(event) }

  describe '#number_of_guests' do
    subject { decorator.number_of_guests }

    context 'with one user' do
      let(:event) { create :event, users_count: 1 }

      it { is_expected.to eql('1 gast') }
    end

    context 'with many user' do
      let(:event) { create :event, users_count: 2 }

      it { is_expected.to eql('2 gasten') }
    end
  end

  # rubocop:disable RSpec/ContextWording
  describe '#floating_action_button' do
    subject { Capybara.string(decorator.floating_action_button) }

    let(:event) { create :event, users_count: 1 }

    context 'container' do
      it { is_expected.to have_css('.fab-add.btn-float-dropdown.dropup') }
    end

    context 'the button itself' do
      it { is_expected.to have_css('.fab-add a.btn.btn-float.btn-secondary[href="#"][aria-expanded="false"][aria-haspopup="true"][data-toggle="dropdown"][role="button"] i.material-icons', text: 'add') }
    end

    context 'dropdown menu' do
      it { is_expected.to have_css('.fab-add .dropdown-menu') }

      context 'menu items' do
        it { is_expected.to have_css('.dropdown-menu a.btn.btn-float.btn-light.btn-sm[href$="/events/new"][role="button"] i.material-icons', text: 'event') }
        it { is_expected.to have_css('.dropdown-menu a.btn.btn-float.btn-light.btn-sm[href$="/articles/new"][role="button"] i.material-icons', text: 'add_shopping_cart') }
      end
    end
  end

  describe '.floating_action_button' do
    subject { Capybara.string(described_class.floating_action_button) }

    context 'container' do
      it { is_expected.to have_css('.fab-add') }
    end

    context 'the button itself' do
      it { is_expected.to have_css('.fab-add a.btn.btn-float.btn-secondary[href$="/events/new"][role="button"] i.material-icons', text: 'add') }
    end
  end
  # rubocop:enable RSpec/ContextWording
end
