# frozen_string_literal: true

#:nodoc:
class ArticleDecorator < ApplicationDecorator
  delegate_all

  def form_title
    title_was || I18n.t('articles.new.title', subject: self.class.model_name.human.downcase)
  end

  def link_to_edit # rubocop:disable Metrics/AbcSize
    return unless h.policy(object).edit?

    tooltip      = h.tooltipify(I18n.t('articles.edit.title'))
    body         = h.material_icon('create', tooltip)
    url          = h.edit_article_path(object)

    h.link_to body, url, default_html_options
  end

  def link_to_destroy
    return unless h.policy(object).destroy?

    tooltip      = h.tooltipify(I18n.t('articles.destroy.title'))
    body         = h.material_icon('delete', tooltip)
    url          = object
    html_options = default_html_options.merge(method: :delete)

    h.link_to body, url, html_options
  end

  def link_to_claim_or_disclaim
    link_to_claim || link_to_disclaim
  end

  # Returns true if article is claimed by another user.
  # If the user views his own article than the method
  # *always* returns false.
  def claimed?
    !claim? && h.current_user != guest.user
  end

  private

  def default_html_options(class_name = nil)
    {
      remote: true,
      class: h.sm_rnd_btn_class(class_name),
      role: :button
    }
  end

  def link_to_claim
    return unless claim?

    tooltip      = h.tooltipify(I18n.t('claims.create.title'))
    url          = h.claim_article_path(object)
    html_options = default_html_options
    html_options.merge!(method: :post)
    html_options.merge!(tooltip)

    h.link_to thumbtack_icon, url, html_options
  end

  def link_to_disclaim
    return unless disclaim?

    tooltip      = h.tooltipify(I18n.t('claims.destroy.title'))
    url          = h.disclaim_article_path(object)
    html_options = default_html_options('text-primary visible')
    html_options.merge!(method: :delete)
    html_options.merge!(tooltip)

    h.link_to thumbtack_icon, url, html_options
  end

  def disclaim?
    claim_policy.destroy?
  end

  def claim?
    claim_policy.create?
  end

  def claim_policy
    ClaimPolicy.new(h.current_user, object)
  end

  def thumbtack_icon
    h.fa_icon('fas', 'thumbtack')
  end
end
