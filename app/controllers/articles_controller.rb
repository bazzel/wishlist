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

    @article = authorize guest.articles.build(article_params).decorate

    if @article.save
      redirect_to event_articles_path(@event), notice: t('.notice', title: @article.title)
    else
      render :new
    end
  end

  def update
    @event = @article.event.decorate

    if @article.update(article_params)
      redirect_to event_articles_path(@event), notice: t('.notice', title: @article.title)
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
    @article = authorize Article.find(params[:id]).decorate
    @store_names = @article.event.store_names
  end

  def article_params
    params.require(:article).permit(:title, :description, :price, :store_names)
  end
end
