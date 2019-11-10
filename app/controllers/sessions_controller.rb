# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_sign_in, only: %i[new]

  def new
    @user = User.new
  end
end
