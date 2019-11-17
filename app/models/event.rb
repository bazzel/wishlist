# frozen_string_literal: true

#:nodoc:
class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }

  has_many :guests, dependent: :destroy
  has_many :users, through: :guests

  before_create :set_slug

  scope :with_user, ->(user) { includes(:users).where(users: { id: user.id }) }

  def to_param
    slug
  end

  def guest?(user)
    users.include?(user)
  end

  private

  def set_slug
    loop do
      self.slug = SecureRandom.uuid
      break unless self.class.where(slug: slug).exists?
    end
  end
end
