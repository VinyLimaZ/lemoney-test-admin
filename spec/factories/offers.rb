# frozen_string_literal: true

FactoryBot.define do
  factory :offer do
    advertiser_name { Faker::Name.unique.first_name }
    url { Faker::Internet.url }
    description { Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false) }
    starts_at { Date.current }
    ends_at { Date.current + 10.days }
    enabled { nil }
    premium { false }

    trait :premium do
      premium { true }
    end

    trait :already_ended do
      ends_at { Date.current - 1.day }
    end

    trait :not_started_yet do
      starts_at { Date.current + 1.day }
    end

    trait :without_ends_at do
      ends_at { nil }
    end

    trait :enabled do
      enabled { true }
    end

    trait :disabled do
      enabled { false }
    end
  end
end
