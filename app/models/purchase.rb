# frozen_string_literal: true

class Purchase < ApplicationRecord
  monetize :price_cents
end
