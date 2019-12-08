# frozen_string_literal: true

#:nodoc:
class Store < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 100 }
end
