# frozen_string_literal: true

#:nodoc:
class ArticlesController < ApplicationController
  before_action :set_event, only: %i[index show edit update]

  def index
  end


  private

  def set_event
    @event = authorize(Event.find_by(slug: params[:event_slug]).decorate, :show?)
  end
end
