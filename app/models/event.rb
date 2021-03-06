# frozen_string_literal: true

#:nodoc:
class Event < ApplicationRecord
  include Sluggable

  validates :title, presence: true, length: { maximum: 255 }

  has_many :guests, dependent: :destroy
  has_many :users, through: :guests
  has_many :articles, through: :guests
  has_many :stores, through: :articles

  before_validation :set_users

  scope :with_user, ->(user) { includes(:users).where(users: { id: user.id }) }

  def invited?(user)
    users.include?(user)
  end

  def guest_emails=(value)
    @guest_emails = parse_tagify_json(value)
  rescue StandardError
    @guest_emails = value.split(/,\s*/)
  end

  def guest_emails
    @guest_emails ||= users.map(&:email)
  end

  def store_names
    stores.distinct.pluck(:name)
  end

  private

  def set_users
    return if @guest_emails.blank?

    self.guests = @guest_emails.map do |email|
      user = User.find_or_initialize_by(email: email)

      if user.valid?
        Guest.find_or_initialize_by(user: user, event: self)
      else
        errors.add(:guest_emails, :invalid)
        return nil
      end
    end
  end

  def parse_tagify_json(value)
    JSON.parse(value).map { |h| h['value'] }
  end
end
