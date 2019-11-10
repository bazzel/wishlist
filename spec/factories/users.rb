# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.org"
    end
    login_token { 'lorem-ipsum' }
    login_token_valid_until { 15.minutes.from_now }

    trait :expired_token do
      login_token_valid_until { 15.minutes.ago }
    end

    # trait :random do
    # email { "#{Faker::Name.unique.first_name.downcase}@kabisa.nl" }
    # login_token { Faker::Crypto.unique.md5 }
    # end
  end

  factory :guest, class: NullUser
end
