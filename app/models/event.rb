# frozen_string_literal: true

#:nodoc:
class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }

  has_many :guests, dependent: :destroy
  has_many :users, through: :guests

  before_create :set_slug
  before_validation :set_users
  after_validation :copy_errors

  attr_accessor :guest_emails

  scope :with_user, ->(user) { includes(:users).where(users: { id: user.id }) }

  def to_param
    slug
  end

  def guest?(user)
    users.include?(user)
  end

  def guest_emails=(value)
    begin
      @guest_emails = parse_tagify_json(value)
    rescue
      @guest_emails = value.split
    end
  end

  def guest_emails
    @guest_emails ||= users.map(&:email)
  end

  def set_users
    self.users = @guest_emails.map do |email|
      User.find_or_initialize_by(email: email)
    end
  end

  def copy_errors
    errors[:users].each do |msg|
      errors.add(:guest_emails, msg)
    end
  end

  private

  def set_slug
    loop do
      self.slug = SecureRandom.uuid
      break unless self.class.where(slug: slug).exists?
    end
  end

  def parse_tagify_json(value)
    JSON.parse(value).map { |h| h['value'] }
  end
end
