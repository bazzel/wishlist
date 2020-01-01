# frozen_string_literal: true

#:nodoc:
class ClaimsController < ApplicationController
  before_action :set_article, only: %i[create destroy]

  def create
    event = @article.event
    claimant = event.guests.find_by(user: current_user)

    @article.claim(claimant)

    flash.now.notice = t('.notice', title: @article.title)
    render 'articles/restore'
  end

  def destroy
    @article.disclaim
    flash.now.notice = t('.notice', title: @article.title)
    render 'articles/restore'
  end

  private

  def set_article
    @article = authorize(Article.find_by(slug: params[:slug]), policy_class: ClaimPolicy).decorate
  end
end
