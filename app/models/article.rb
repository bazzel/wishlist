# frozen_string_literal: true

#:nodoc:
class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :price, numericality: { greater_than: 0, less_than: 100_000 }, allow_nil: true

  belongs_to :guest
end
