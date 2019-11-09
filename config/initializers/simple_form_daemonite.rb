# frozen_string_literal: true

SimpleForm.setup do |config|
  # Custom wrapper to support floating label text fields
  # See http://daemonite.github.io/material/docs/4.1/material/text-fields/#floating-label-text-fields.
  config.wrappers :vertical_form_w_floating_label, tag: 'div', class: 'form-group floating-label', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label
    b.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  config.wrappers :toggle_buttons, tag: :div, class: 'btn-group form-group', item_wrapper_tag: false, html: { data: { toggle: 'buttons'}, role: 'group' } do |b|
    b.use :html5
    b.optional :readonly
    b.use :input
  end
end

