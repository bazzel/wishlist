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
    event = @article.event

    if @article.disclaim
      redirect_to_index(event)
    end
  end

  private

  def set_article
    @article = authorize(Article.find_by(slug: params[:slug]), policy_class: ClaimPolicy).decorate
  end

  def redirect_to_index(event)
    redirect_to event_articles_path(event), notice: t('.notice', title: @article.title)
  end
end
