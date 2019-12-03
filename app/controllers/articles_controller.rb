# frozen_string_literal: true

#:nodoc:
class ArticlesController < ApplicationController
  before_action :set_event, only: %i[index new create]

  def index; end

  def new
    @article = authorize Article.new
  end

  def create
    guest = @event.guests.find_by(user: current_user)

    @article = authorize guest.articles.build(article_params)

    if @article.save
      redirect_to event_articles_path(@event)
    else
      render :new
    end
  end

  private

  def set_event
    @event = authorize(Event.find_by(slug: params[:event_slug]).decorate, :show?)
  end

  def article_params
    params.require(:article).permit(:title)
  end
end
