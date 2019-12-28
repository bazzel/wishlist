# frozen_string_literal: true

#:nodoc:
class ArticlesController < ApplicationController
  before_action :set_event, only: %i[index new create]
  before_action :set_article, only: %i[edit update destroy restore]

  def index; end

  def new
    @article = authorize Article.new.decorate
  end

  def edit; end

  def create
    guest = @event.guests.find_by(user: current_user)

    @article = authorize guest.articles.build(article_params)

    if @article.save
      redirect_to_index(@event)
    else
      @article = @article.decorate
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to_index(@article.event)
    else
      render :edit
    end
  end

  def destroy
    @article.discard

    flash.now.notice = t('.notice', title: @article.title)
  end

  def restore
    @article.undiscard

    flash.now.notice = t('.notice', title: @article.title)
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

  def redirect_to_index(event)
    redirect_to event_articles_path(event), notice: t('.notice', title: @article.title)
  end
end
