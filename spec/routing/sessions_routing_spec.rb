# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for sessions', type: :routing do
  describe 'GET /sign_in' do
    it { expect(get('sign_in')).to route_to('sessions#new') }

    it { expect(get: sign_in_path).to route_to('sessions#new') }
  end
end
