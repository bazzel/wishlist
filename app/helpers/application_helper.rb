# frozen_string_literal: true

#:nodoc:
module ApplicationHelper
  def app_name
    Rails.application.config.app_name
  end

  def floating_action_button
    return if current_page?(controller: 'events', action: 'new')

    tag.div(class: 'fab-add') do
      link_to(new_event_path, class: fab_class('btn-secondary'), role: :button) do
        material_icon 'add'
      end
    end
  end
end
