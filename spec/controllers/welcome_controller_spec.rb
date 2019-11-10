# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET #index' do
    context 'with anonymous user' do
      it 'returns http success' do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
