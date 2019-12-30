# frozen_string_literal: true

#:nodoc:
class ClaimsController < ApplicationController
  before_action :set_article, only: %i[create destroy]

  def create
    event = @article.event
    claimant = event.guests.find_by(user: current_user)

    if @article.claim(claimant)
      redirect_to_index(event)
    end
  end

  def destroy
    @article.discard

    flash.now.notice = t('.notice', title: @article.title)
  end

  private

  def set_article
    @article = authorize Article
               .find_by(slug: params[:article_slug])
               .decorate
  end

  def redirect_to_index(event)
    redirect_to event_articles_path(event), notice: t('.notice', title: @article.title)
  end
end
