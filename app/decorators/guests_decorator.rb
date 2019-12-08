# frozen_string_literal: true

#:nodoc:
class GuestsDecorator < Draper::CollectionDecorator
  delegate :find_by
end
