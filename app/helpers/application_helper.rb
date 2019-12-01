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

  def floating_action_button_w_dropdown
    tag.div(class: 'fab-add btn-float-dropdown dropup') do
      concat(tag.button(class: 'btn btn-float btn-secondary', aria: { expanded: false, haspopup: true }, data: { toggle: :dropdown }, type: :button) do
        material_icon('add')
      end)
      concat(tag.div(class: 'dropdown-menu') do
        concat(link_to(new_event_article_path(@event), class: 'btn btn-float btn-light btn-sm', role: :button) do
          material_icon('add_shopping_cart')
        end)
        concat(tag.button(class: 'btn btn-float btn-light btn-sm', type: :button) do
          material_icon('event')
        end)
      end)
    end
  end
end
