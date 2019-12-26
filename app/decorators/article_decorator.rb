# frozen_string_literal: true

#:nodoc:
class ArticleDecorator < ApplicationDecorator
  delegate_all

  def form_title
    title_was || I18n.t('articles.new.title', subject: self.class.model_name.human.downcase)
  end

  def link_to_edit # rubocop:disable Metrics/AbcSize
    return unless h.policy(object).edit?

    tooltip      = h.tooltipify(I18n.t('articles.edit.title', subject: Article.model_name.human))
    body         = h.material_icon('create', tooltip)
    url          = h.edit_article_path(object)
    html_options = { remote: true, class: h.sm_rnd_btn_class, role: :button }

    h.link_to body, url, html_options
  end

  def link_to_destroy # rubocop:disable Metrics/AbcSize
    return unless h.policy(object).destroy?

    tooltip      = h.tooltipify(I18n.t('articles.destroy.title', subject: Article.model_name.human))
    body         = h.material_icon('delete', tooltip)
    url          = object
    html_options = { method: :delete, remote: true, class: h.sm_rnd_btn_class, role: :button }

    h.link_to body, url, html_options
  end
end
