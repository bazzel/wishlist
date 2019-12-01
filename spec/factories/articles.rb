# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { 'MyString' }
    guest { nil }
  end
end
