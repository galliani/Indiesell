# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    association :purchase

    url         {  }
    expiry      { Time.current }
  end
end
