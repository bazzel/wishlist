# frozen_string_literal: true

#:nodoc:
class Guest < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :articles, dependent: :destroy
  has_many :claims, class_name: 'Article', foreign_key: 'claimant_id', dependent: :nullify

  delegate :email, to: :user
end
