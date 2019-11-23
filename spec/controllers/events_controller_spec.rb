# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:current_user)       { create :user }
  let(:valid_session)      { { user_id: current_user.id } }

  describe 'GET #new' do
    def do_get
      get :new, session: valid_session
    end

    it 'returns a success response' do
      do_get
      expect(response).to be_successful
    end

    it 'assigns an event' do
      do_get
      expect(assigns[:event]).to be_a(Event)
    end
  end

  describe 'GET #show' do
    def do_get
      get :show, params: { slug: event.to_param }, session: valid_session
    end

    let!(:event) { create :event, users: [current_user] }

    it 'returns a success response' do
      do_get
      expect(response).to be_successful
    end

    it 'decorates the event' do
      do_get
      expect(assigns(:event)).to be_decorated
    end
  end

  describe 'POST #create' do
    def do_post(attributes)
      post :create, params: { event: attributes }, session: valid_session
    end

    let(:valid_attributes) do
      attributes_for(:event).merge(guest_emails: [{ value: current_user.email }].to_json)
    end

    let(:invalid_attributes) do
      attributes_for(:event, :invalid)
    end

    context 'with valid params' do
      it 'creates a new Event' do
        expect do
          do_post(valid_attributes)
        end.to change(Event, :count).by(1)
      end

      it 'redirects to the created event' do
        do_post(valid_attributes)
        expect(response).to redirect_to(Event.last)
      end

      it 'adds the current user as the first guest' do
        do_post(valid_attributes)
        expect(Event.first.users.size).to be(1)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        do_post(invalid_attributes)
        expect(response).to be_successful
      end

      it 'renders the new template' do
        do_post(invalid_attributes)
        expect(response).to render_template(:new)
      end
    end
  end
end
