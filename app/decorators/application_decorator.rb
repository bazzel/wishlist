# frozen_string_literal: true

#:nodoc:
class ApplicationDecorator < Draper::Decorator
  # Define methods for all decorated objects.
  # Helpers are accessed through `helpers` (aka `h`). For example:
  #
  #   def percent_amount
  #     h.number_to_percentage object.amount, precision: 2
  #   end
  def dom_id(prefix = nil)
    h.dom_id(object, prefix)
  end
end
