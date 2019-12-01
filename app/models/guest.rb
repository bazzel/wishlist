# frozen_string_literal: true

#:nodoc:
class Guest < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :articles, dependent: :destroy

  delegate :email, to: :user
end
