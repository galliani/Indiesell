# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached  :display_picture
  has_many_attached :images

  monetize :price_cents
end
