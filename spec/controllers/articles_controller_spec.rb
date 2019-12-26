# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:current_user)  { create :user }
  let(:valid_session) { { user_id: current_user.id } }
  let(:event)         { create :event, guest_emails: [current_user.email] }
  let!(:article)      { create :article, guest: event.guests.first }

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

    it 'decorates the event' do
      do_get
      expect(assigns(:event)).to be_decorated
    end

    it 'assigns an article' do
      do_get
      expect(assigns[:article]).to be_an(Article)
    end

    it 'decorates the article' do
      do_get
      expect(assigns(:article)).to be_decorated
    end

    it 'assigns store names' do
      do_get
      expect(assigns(:store_names)).to be_an(Array)
    end
  end

  describe 'GET #edit' do
    def do_get
      get :edit, xhr: true, params: { slug: article.to_param }, session: valid_session
    end

    it 'returns a success response' do
      do_get
      expect(response).to be_successful
    end

    it 'does not assign an event' do
      do_get
      expect(assigns[:event]).to be_nil
    end

    it 'assigns an article' do
      do_get
      expect(assigns[:article]).to eql(article)
    end

    it 'decorates the article' do
      do_get
      expect(assigns(:article)).to be_decorated
    end

    it 'assigns store names' do
      do_get
      expect(assigns(:store_names)).to be_an(Array)
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
      it 'creates a article' do
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

      it 'does not need to decorate the article' do
        do_post(valid_attributes)
        expect(assigns(:article)).not_to be_decorated
      end
    end

    context 'with invalid params' do
      it 'does not create a article' do
        expect do
          do_post(invalid_attributes)
        end.not_to change(event.articles, :count)
      end

      it 'renders new' do
        do_post(invalid_attributes)
        expect(response).to render_template(:new)
      end

      it 'decorates the article' do
        do_post(invalid_attributes)
        expect(assigns(:article)).to be_decorated
      end

      it 'assigns store names' do
        do_post(invalid_attributes)
        expect(assigns(:store_names)).to be_an(Array)
      end
    end
  end

  describe 'PUT #update' do
    def do_put(attributes)
      post :update, xhr: true, params: attributes, session: valid_session
    end

    let(:new_title) { 'Muspi Merol' }
    let(:valid_attributes) do
      {
        slug: article.to_param,
        article: {
          title: new_title
        }
      }
    end

    let(:invalid_attributes) do
      {
        slug: article.to_param,
        article: {
          title: ''
        }
      }
    end

    context 'with valid params' do
      it 'update the article' do
        expect do
          do_put(valid_attributes)
          article.reload
        end.to change(article, :title).to(new_title)
      end

      it 'sets a flash notice' do
        do_put(valid_attributes)
        expect(request.flash.notice).to match(/Artikel 'Muspi Merol' is bijgewerkt/)
      end

      it 'redirects to the index page' do
        do_put(valid_attributes)
        expect(response).to redirect_to(event_articles_path(event))
      end
    end

    context 'with invalid params' do
      it 'does not update the article' do
        expect do
          do_put(invalid_attributes)
          article.reload
        end.not_to change(article, :title)
      end

      it 'renders edit' do
        do_put(invalid_attributes)
        expect(response).to render_template(:edit)
      end

      it 'decorates the article' do
        do_put(invalid_attributes)
        expect(assigns(:article)).to be_decorated
      end

      it 'assigns store names' do
        do_put(invalid_attributes)
        expect(assigns(:store_names)).to be_an(Array)
      end
    end
  end

  describe 'DELETE #destroy' do
    def do_delete
      delete :destroy, xhr: true, params: {slug: article.to_param}, session: valid_session
    end

    it 'destroys the requested article' do
      expect {
        do_delete
      }.to change(Article, :count).by(-1)
    end

    it 'renders destroy' do
      do_delete
      expect(response).to render_template(:destroy)
    end
  end
end
