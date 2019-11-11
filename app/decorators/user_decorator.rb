# frozen_string_literal: true

#:nodoc:
class UserDecorator < ApplicationDecorator
  delegate_all

  # TODO: Once we have the user's name
  # we can return "John Smith" <johnsemail@hisserver.com>
  def mail_to
    email
  end
end
