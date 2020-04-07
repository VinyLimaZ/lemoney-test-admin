# frozen_string_literal: true

FactoryBot.define do
  factory :offer do
    advertiser_name { Faker::Name.unique.first_name }
    url { Faker::Internet.url }
    description { Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false) }
    starts_at { Date.current }
    ends_at { Date.current + 10.days }
    premium { false }

    trait :premium do
      premium { true }
    end

    trait :without_ends_at do
      ends_at { nil }
    end
  end
end
