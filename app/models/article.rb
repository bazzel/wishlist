# frozen_string_literal: true

#:nodoc:
class Article < ApplicationRecord
  include Sluggable

  has_and_belongs_to_many :stores # rubocop:disable Rails/HasAndBelongsToMany
  belongs_to :guest

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 2**10 }
  validates :price, numericality: { greater_than: 0, less_than: 100_000 }, allow_nil: true

  before_validation :set_stores

  delegate :event, :user, to: :guest

  acts_as_paranoid

  def store_names
    @store_names ||= stores.map(&:name)
  end

  def store_names=(value)
    @store_names = parse_tagify_json(value)
  rescue StandardError
    @store_names = value.split(/,\s*/)
  end

  private

  def parse_tagify_json(value)
    JSON.parse(value).map { |h| h['value'] }
  end

  def set_stores
    return if @store_names.nil?

    self.stores = @store_names.map do |name|
      store = Store.find_or_initialize_by(name: name)

      if store.valid?
        store
      else
        errors.add(:store_names, :invalid)
        return nil
      end
    end
  end
end
