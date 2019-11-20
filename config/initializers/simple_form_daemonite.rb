# frozen_string_literal: true

SimpleForm.setup do |config|
  # Custom wrapper to support text field boxes
  # See http://daemonite.github.io/material/docs/4.1/material/text-fields/#text-field-boxes
  config.wrappers :vertical_form_w_text_field_boxes, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.wrapper tag: :div, class: 'textfield-box' do |c|
      c.optional :label
      c.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: false
      c.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      c.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  config.wrappers :toggle_buttons, tag: :div, class: 'btn-group form-group', item_wrapper_tag: false, html: { data: { toggle: 'buttons'}, role: 'group' } do |b|
    b.use :html5
    b.optional :readonly
    b.use :input
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :vertical_form_w_text_field_boxes
end

