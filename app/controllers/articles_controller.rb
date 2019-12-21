# frozen_string_literal: true

#:nodoc:
class ArticlesController < ApplicationController
  before_action :set_event, only: %i[index new create]
  before_action :set_article, only: %i[edit update]

  def index; end

  def new
    @article = authorize Article.new.decorate
  end

  def edit; end

  def create
    guest = @event.guests.find_by(user: current_user)

    @article = authorize guest.articles.build(article_params)

    if @article.save
      redirect_to event_articles_path(@event), notice: t('.notice', title: @article.title)
    else
      @article = @article.decorate
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to event_articles_path(@article.event), notice: t('.notice', title: @article.title)
    else
      render :edit
    end
  end

  private

  def set_event
    @event = authorize(
      Event
        .includes(:stores, guests: %i[user articles])
        .find_by(slug: params[:event_slug])
        .decorate,
      :show?
    )
    @store_names = @event.store_names
  end

  def set_article
    @article = authorize Article
      .find_by(slug: params[:slug])
      .decorate
    @store_names = @article.event.store_names
  end

  def article_params
    params.require(:article).permit(:title, :description, :price, :store_names)
  end
end
