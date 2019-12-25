# frozen_string_literal: true

#:nodoc:
module ApplicationHelper
  def app_name
    Rails.application.config.app_name
  end

  def modal_id
    'modal'
  end

  def hamburger_menu(&block)
    return if (menu_items = capture { block.call }).blank?

    content_tag(:div, class: 'dropdown') do
      concat(menu_button)
      concat(content_tag(:div, class: 'dropdown-menu menu dropdown-menu-right') do
        menu_items
      end)
    end
  end

  def menu_button
    options = {
      class: sm_rnd_btn_class,
      aria: { expanded: false, haspopup: true },
      data: { toggle: 'dropdown' },
      type: 'button'
    }

    tag.button(options) do
      material_icon('more_vert', tooltipify(t('helpers.options')))
    end
  end
end
