# frozen_string_literal: true

#:nodoc:
class EventDecorator < ApplicationDecorator
  delegate_all

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
end
