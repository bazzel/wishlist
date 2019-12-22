# frozen_string_literal: true

require 'active_support/concern'

# Include this concern into a model when it has a slug attribute.
# Its value is set upon creation and is used
# in a URL fragment (e.g. /events/2db6aef0-94ae-4569-9...)
#
# @see https://hackernoon.com/using-custom-slugs-for-rails-urls-500eb3f58f3c
module Sluggable
  extend ActiveSupport::Concern

  included do
    before_create :set_slug
  end

  def to_param
    slug
  end

  private

  def set_slug
    loop do
      self.slug = SecureRandom.uuid
      break unless self.class.where(slug: slug).exists?
    end
  end
end
