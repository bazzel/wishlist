# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { 'MyString' }

    transient do
      users_count { 0 }
    end

    after(:build) do |event, evaluator|
      evaluator.users_count.times do
        event.users << build(:user)
      end
    end

    trait :invalid do
      title { '' }
    end
  end
end
