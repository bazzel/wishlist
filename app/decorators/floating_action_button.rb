# frozen_string_literal: true

# This concern should be included by the EventDecorator
# and provide you with some methods for
# rendering a floating action button
# @see http://daemonite.github.io/material/docs/4.1/material/buttons/#floating-action-buttons
module FloatingActionButton
  extend ActiveSupport::Concern

  class_methods do
    # This renders just a floating action button (without a dropdown).
    def floating_action_button
      h.fab_wrapper do
        h.fab_button(h.new_event_path)
      end
    end
  end

  # This renders a floating action button
  # that has a dropdown menu
  def floating_action_button
    h.fab_wrapper('btn-float-dropdown dropup') do
      h.concat h.fab_button
      h.concat dropdown
    end
  end

  private

  def dropdown
    h.fab_dropdown_wrapper do
      h.concat menu_item_new_event
      h.concat menu_item_new_article
    end
  end

  def menu_item_new_event
    h.fab_menu_item(h.new_event_path) do
      h.material_icon('event')
    end
  end

  def menu_item_new_article
    h.fab_menu_item(h.new_event_article_path(model)) do
      h.material_icon('add_shopping_cart')
    end
  end
end
