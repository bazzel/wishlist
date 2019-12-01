# frozen_string_literal: true

#:nodoc:
class ArticlesController < ApplicationController
  before_action :set_event, only: %i[index new]

  def index; end

  def new
    @article = authorize Article.new
  end

  private

  def set_event
    @event = authorize(Event.find_by(slug: params[:event_slug]).decorate, :show?)
  end
end
