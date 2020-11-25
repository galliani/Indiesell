# frozen_string_literal: true

class Purchase < ApplicationRecord
  belongs_to :product

  monetize :price_cents
end
