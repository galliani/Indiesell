# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name          { "Book #{rand(10000)}" }
    description   { "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." }
    price_cents   { 20_00 }
    is_live       { true  }

    trait :draft do
      is_live     { false }
    end

    trait :with_pictures_for_store do
      display_picture { 
        fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'product-display-pic.png'), 'image/png')
      }
    end

    trait :with_consumables do
      after :create do |product|
        file_path = Rails.root.join('spec', 'fixtures', 'files', 'test-image.jpg')
        file      = fixture_file_upload(file_path, 'image/jpg')

        product.consumables.attach(file)
      end
    end
  end
end
