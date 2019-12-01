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

  def self.floating_action_button
    h.tag.div(class: 'fab-add') do
      h.link_to(h.new_event_path, class: h.fab_class('btn-secondary'), role: :button) do
        h.material_icon 'add'
      end
    end
  end

  def floating_action_button
    h.tag.div(class: 'fab-add btn-float-dropdown dropup') do
      h.concat(h.tag.button(class: 'btn btn-float btn-secondary', aria: { expanded: false, haspopup: true }, data: { toggle: :dropdown }, type: :button) do
        h.material_icon('add')
      end)
      h.concat(h.tag.div(class: 'dropdown-menu') do
        h.concat(h.link_to(h.new_event_article_path(model), class: 'btn btn-float btn-light btn-sm', role: :button) do
          h.material_icon('add_shopping_cart')
        end)
        h.concat(h.tag.button(class: 'btn btn-float btn-light btn-sm', type: :button) do
          h.material_icon('event')
        end)
      end)
    end
  end
end
