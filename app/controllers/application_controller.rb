# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_sign_in

  helper_method :current_user

  private
  def current_user
    User.find_by(id: session[:user_id]) || NullUser.new
  end

  def require_sign_in
    if current_user.anonymous?
      redirect_to sign_in_path
    end
  end
end
