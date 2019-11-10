# frozen_string_literal: true

# Handles signin in and out of users.
class SessionsController < ApplicationController
  skip_before_action :require_sign_in, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @email = params[:user][:email]
    @user  = User.find_or_initialize_by(email: @email)

    if @user.update(login_token: SecureRandom.urlsafe_base64,
        login_token_valid_until: 30.minutes.from_now)
      SessionsMailer.magic_link(@user).deliver
    else
      render :new
    end
  end
end
