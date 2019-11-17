# frozen_string_literal: true

#:nodoc:
class Guest < ApplicationRecord
  belongs_to :event
  belongs_to :user
end
