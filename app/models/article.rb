# frozen_string_literal: true

#:nodoc:
class Article < ApplicationRecord
  belongs_to :guest
end
