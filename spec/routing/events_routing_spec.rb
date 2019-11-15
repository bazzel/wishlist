# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/events').to route_to('events#index')
    end

    it 'routes to #new' do
      expect(get: '/events/new').to route_to('events#new')
    end
  end

  describe 'named routes' do
    it do
      expect(get: events_path).to route_to('events#index')
    end

    it do
      expect(get: new_event_path).to route_to('events#new')
    end
  end
end
