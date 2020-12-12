# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
    association             :product

    price_cents             { 20_00 }
    price_currency          { 'USD' }
    token                   { SecureRandom.uuid }
    gateway_id              { 1 }
    gateway_customer_id     { SecureRandom.uuid }
    customer_email          { "purchaser_#{rand(1000)}@mail.com" }

    trait :successful do
      is_paid { true }

      after :create do |purchase|
        if purchase.product
          purchase.links = ConsumableLinksCreator.new.perform(product: purchase.product)
          purchase.save
        end
      end
    end
  end
end
