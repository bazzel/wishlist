# frozen_string_literal: true

# Collection of bootstrap related helpers
module BootstrapHelper
  def bs_snackbar
    render(Material::Snackbar, flash: flash)
  end

  # @param icon [String] For all available icons, please refer to Material icons library (https://material.io/resources/icons/)
  def material_icon(icon, options = {})
    options.deep_merge!(class: 'material-icons')
    content_tag(:i, icon, options)
  end

  def tooltipify(title, data_attributes = {})
    data = { toggle: 'tooltip' }.merge(data_attributes)
    {
      data: data,
      title: title
    }
  end

  # Minimal set of classnames needed to create
  # a small round button.
  # Often used with an icon as button value.
  # @param [String|Array<String>] extra classnames that are added to the output
  # @return [String] classnames
  # @example
  #   sm_rnd_btn_class
  #   #=> 'btn-float btn btn-sm shadow-none'
  #
  #   sm_rnd_btn_class('my-1 text-primary')
  #   #=> 'btn-float btn btn-sm shadow-none my-1 text-primary'
  #
  #   sm_rnd_btn_class(%(my-1 text-primary))
  #   #=> 'btn-float btn btn-sm shadow-none my-1 text-primary'
  def sm_rnd_btn_class(classnames = nil)
    default_classnames = Array(fab_class(%w[btn-sm shadow-none]))
    join_classnames(default_classnames, classnames)
  end

  # Renders a close icon
  # @see http://daemonite.github.io/material/docs/4.1/utilities/close-icon/
  def close_icon(options = {})
    # Deep merge and join values
    options.deep_merge!(close_icon_default_options) do |_, this_val, other_val|
      [this_val, other_val].join(' ').strip
    end

    tag.button(options) do
      tag.span('×', aria: { hidden: true })
    end
  end

  def close_icon_default_options
    {
      class: 'close',
      type: :button,
      aria: {
        label: 'Close'
      }
    }
  end

  private

  def join_classnames(default_classnames, classnames)
    (Array(default_classnames) + Array(classnames)).join(' ')
  end
end
