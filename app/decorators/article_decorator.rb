# frozen_string_literal: true

#:nodoc:
class ArticleDecorator < ApplicationDecorator
  delegate_all

  def form_title
    title_was || I18n.t('articles.new.title', subject: self.class.model_name.human.downcase)
  end
end
