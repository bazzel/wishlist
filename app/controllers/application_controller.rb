# frozen_string_literal: true

#:nodoc:
class ApplicationController < ActionController::Base
  include Pundit

  before_action :require_sign_in
  before_action :make_action_mailer_use_request_host_and_protocol

  after_action :verify_authorized, except: :index

  helper_method :current_user

  def index; end

  def current_user=(user)
    session[:user_id] = user.id
  end

  def current_user
    User.find_by(id: session[:user_id]) || NullUser.new
  end

  private

  def require_sign_in
    redirect_to sign_in_path if current_user.anonymous?
  end

  def make_action_mailer_use_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
