# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { 'MyString' }
    slug { 'lorem-ipsum' }

    trait :invalid do
      title { '' }
    end
  end
end
