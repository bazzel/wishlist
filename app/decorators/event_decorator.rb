# frozen_string_literal: true

#:nodoc:
class EventDecorator < ApplicationDecorator
  include FloatingActionButton
  delegate_all
  decorates_association :articles
  decorates_association :guests

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def number_of_users
    users_count = users.size

    [
      users_count,
      Guest.model_name.human.pluralize(users_count, I18n.locale).downcase
    ].join(' ')
  end

  def hamburger_menu
    h.hamburger_menu do
      h.concat link_to_edit
    end
  end

  def link_to_edit
    return unless h.policy(object).edit?

    h.link_to I18n.t('helpers.submit.edit'), h.edit_event_path(object), class: 'dropdown-item'
  end
end
