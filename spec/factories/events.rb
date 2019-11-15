# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { 'MyString' }

    trait :invalid do
      title { '' }
    end
  end
end
