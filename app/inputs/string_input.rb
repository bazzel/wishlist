# frozen_string_literal: true

require 'text_field_box'

# Redefine SimpleForm StringInput class
class StringInput < SimpleForm::Inputs::StringInput
  include TextFieldBox
end
