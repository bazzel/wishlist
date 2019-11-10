# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    def do_get
      get :new
    end

    it 'returns a success response' do
      do_get
      expect(response).to be_successful
    end

    it 'assigns a `user` variable' do
      do_get
      expect(assigns[:user]).to be_a(User)
    end
  end
end
