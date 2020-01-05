require 'rails_helper'

RSpec.describe ClaimsController, type: :controller do
  let(:a_user)        { create :user }
  let(:current_user)  { create :user }
  let(:valid_session) { { user_id: current_user.id } }
  let(:event)         { create :event, guest_emails: [a_user.email, current_user.email].join(',') }
  let!(:article)      { create :article, guest: guest }

  describe 'POST #create' do
    let(:guest)      { event.guests.first }
    let(:attributes) {{ slug: article.to_param }}

    def do_post(attributes)
      post :create, xhr: true, params: attributes, session: valid_session
    end

    it 'assigns the article for the view' do
      do_post attributes
      expect(assigns(:article)).to eql(article)
    end

    it 'claims the article' do
      expect do
        do_post attributes
        article.reload
      end.to change(article, :claimant).to(event.guests.last)
    end

    it 'renders the articles/restore template' do
      expect(do_post(attributes)).to render_template('articles/restore')
    end
  end

  describe 'DELETE #destroy' do
    before           { article.claim(guest) }

    let(:guest)      { event.guests.last }
    let(:attributes) {{ slug: article.to_param }}

    def do_delete(attributes)
      delete :destroy, xhr: true, params: attributes, session: valid_session
    end


    it 'assigns the article for the view' do
      do_delete attributes
      expect(assigns(:article)).to eql(article)
    end

    it 'disclaims the article' do
      expect do
        do_delete attributes
        article.reload
      end.to change(article, :claimant).from(event.guests.last).to(nil)
    end

    it 'renders the articles/restore template' do
      expect(do_delete(attributes)).to render_template('articles/restore')
    end
  end

end
