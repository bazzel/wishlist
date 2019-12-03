# frozen_string_literal: true

#:nodoc:
module ApplicationHelper
  def app_name
    Rails.application.config.app_name
  end

  def new_article_modal_id
    'new_article_modal'
  end
end
