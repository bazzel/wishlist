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

  describe 'POST /sessions' do
    let(:email) do
      'john.doe@example.org'
    end
    let(:options) do
      {
        user: {
          email: email
        }
      }
    end

    def do_post(params = options)
      post :create, params: params
    end

    describe 'on success' do
      before do
        allow(SessionsMailer).to receive(:magic_link)
          .and_return(sessions_mailer_mock)
      end

      let(:sessions_mailer_mock) do
        # rubocop:disable RSpec/VerifiedDoubles
        spy('ActionMailer::MessageDelivery')
        # rubocop:enable RSpec/VerifiedDoubles
      end

      context 'with new user' do
        it 'creates the user' do
          expect do
            do_post
          end.to change(User, :count).by(1)
        end

        it 'assigns the email address' do
          do_post
          expect(User.first.email).to eql(email)
        end

        it 'sets the login token' do
          do_post
          expect(User.first.login_token).not_to be_nil
        end

        it 'expires in some time' do
          do_post
          expect(User.first.login_token_valid_until).to be_within(1.second)
            .of(30.minutes.from_now)
        end

        # rubocop:disable RSpec/MultipleExpectations
        it 'sends a mail' do
          do_post
          expect(SessionsMailer).to have_received(:magic_link)
          expect(sessions_mailer_mock).to have_received(:deliver)
        end
        # rubocop:enable RSpec/MultipleExpectations

        it 'renders the create template' do
          expect(do_post).to render_template(:create)
        end
      end

      context 'with existing user' do
        before do
          create(:user, email: email)
        end

        it 'does not create a user' do
          expect { do_post }.not_to change(User, :count)
        end

        it 'sets the login token' do
          do_post
          expect(User.first.login_token).not_to be_nil
        end

        it 'expires in some time' do
          do_post
          expect(User.first.login_token_valid_until).to be_within(1.second)
            .of(30.minutes.from_now)
        end

        # rubocop:disable RSpec/MultipleExpectations
        it 'sends a mail' do
          do_post
          expect(SessionsMailer).to have_received(:magic_link)
          expect(sessions_mailer_mock).to have_received(:deliver)
        end
        # rubocop:enable RSpec/MultipleExpectations

        it 'renders the create template' do
          expect(do_post).to render_template(:create)
        end
      end
    end
  end

  describe 'GET sessions/:token' do
    let(:login_token) { 'lorem-ipsum' }

    describe 'on success' do
      let!(:user) do
        create :user
      end

      def do_get
        get 'show', params: {
          token: login_token
        }
      end

      it 'resets the token' do
        expect do
          do_get
          user.reload
        end.to change(user, :login_token).to(nil).and \
          change(user, :login_token_valid_until)
      end

      it 'assigns the user' do
        do_get
        expect(controller.current_user).to eql(user)
      end

      it 'redirects to the root page' do
        expect(do_get).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE sessions' do
    before { controller.current_user = build_stubbed(:user) }

    def do_delete
      delete 'destroy'
    end

    it 'nullifies the current user' do
      do_delete
      expect(controller.current_user).to be_anonymous
    end

    it 'redirect to the sign in path' do
      expect(do_delete).to redirect_to(root_path)
    end
  end
end
