# frozen_string_literal: true

#:nodoc:
class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }

  belongs_to :guest
end
