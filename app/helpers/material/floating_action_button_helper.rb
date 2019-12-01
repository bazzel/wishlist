# frozen_string_literal: true

module Material
  # Collection of floating action button related helpers
  # @see http://daemonite.github.io/material/docs/4.1/material/buttons/#floating-action-buttons
  module FloatingActionButtonHelper
    # Minimal set of classnames needed to create
    # a floating action button.
    # Often used with an icon as button value.
    # @param [String|Array<String>] extra classnames that are added to the output
    # @return [String] classnames
    # @example
    #   fab_class #=> 'btn-float btn'
    #   fab_class('my-1 text-primary') #=> 'btn-float btn my-1 text-primary'
    #   fab_class(%(my-1 text-primary)) #=> 'btn-float btn my-1 text-primary'
    def fab_class(classnames = nil)
      default_classnames = %w[btn-float btn]
      join_classnames(default_classnames, classnames)
    end

    def fab_wrapper(classnames = nil)
      tag.div(class: join_classnames('fab-add', classnames)) do
        yield
      end
    end

    def fab_button(path = '#')
      link_to(path, fab_button_options(path)) do
        material_icon 'add'
      end
    end

    def fab_button_options(path)
      options = {
        class: fab_class('btn-secondary'),
        role: :button
      }

      if path == '#'
        options[:aria] = { expanded: false, haspopup: true }
        options[:data] = { toggle: :dropdown }
      end

      options
    end

    def fab_menu_item(path)
      link_to(path, class: fab_class('btn-light btn-sm'), role: :button) do
        yield
      end
    end

    def fab_dropdown_wrapper
      tag.div(class: 'dropdown-menu') do
        yield
      end
    end
  end
end
