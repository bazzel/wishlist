# frozen_string_literal: true

#:nodoc:
class GuestDecorator < ApplicationDecorator
  delegate_all
  decorates_association :articles, scope: :kept
end
