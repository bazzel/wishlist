# frozen_string_literal: true

#:nodoc:
module ApplicationHelper
  def app_name
    Rails.application.config.app_name
  end

  def modal_id
    'modal'
  end
end
