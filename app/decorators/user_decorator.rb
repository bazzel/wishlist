# frozen_string_literal: true

#:nodoc:
class UserDecorator < ApplicationDecorator
  delegate_all

  def to_label
    # return name if name.present?

    email
  end
  alias to_s to_label
end
