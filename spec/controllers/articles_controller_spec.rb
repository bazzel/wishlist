# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:current_user)  { create :user }
  let(:valid_session) { { user_id: current_user.id } }
  let(:event)         { create :event, guest_emails: [current_user.email] }

  describe 'GET #index' do
    def do_get
      get :index, params: { event_slug: event.to_param }, session: valid_session
    end

    it 'returns a success response' do
      do_get
      expect(response).to be_successful
    end

    it 'assigns an event' do
      do_get
      expect(assigns[:event]).to eql(event)
    end
  end

  describe 'GET #new' do
    def do_get
      get :new, xhr: true, params: { event_slug: event.to_param }, session: valid_session
    end

    it 'returns a success response' do
      do_get
      expect(response).to be_successful
    end

    it 'assigns an event' do
      do_get
      expect(assigns[:event]).to eql(event)
    end

    it 'assigns an article' do
      do_get
      expect(assigns[:article]).to be_an(Article)
    end
  end

  describe 'POST #create' do
    def do_post(attributes)
      post :create, xhr: true, params: attributes, session: valid_session
    end

    let(:valid_attributes) do
      {
        event_slug: event.to_param,
        article: {
          title: 'Lorem'
        }
      }
    end

    let(:invalid_attributes) do
      {
        event_slug: event.to_param,
        article: {
          title: ''
        }
      }
    end

    context 'with valid params' do
      it 'creates a new Article' do
        expect do
          do_post(valid_attributes)
        end.to change(event.articles, :count).by(1)
      end

      it 'references the current user' do
        do_post(valid_attributes)
        expect(Article.last.guest.email).to eql(current_user.email)
      end

      it 'sets a flash notice' do
        do_post(valid_attributes)
        expect(request.flash.notice).to match(/Artikel 'Lorem' is toegevoegd/)
      end

      it 'redirects to the index page' do
        do_post(valid_attributes)
        expect(response).to redirect_to(event_articles_path(event))
      end
    end

    context 'with invalid params' do
      it 'does create a new Article' do
        expect do
          do_post(invalid_attributes)
        end.not_to change(event.articles, :count)
      end

      it 'renders new' do
        do_post(invalid_attributes)
        expect(response).to render_template(:new)
      end
    end
  end
end
