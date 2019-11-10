# frozen_string_literal: true

# Handles signin in and out of users.
class SessionsController < ApplicationController
  skip_before_action :require_sign_in, only: %i[new]

  def new
    @user = User.new
  end
end
