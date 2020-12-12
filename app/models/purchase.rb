# frozen_string_literal: true

class Purchase < ApplicationRecord
  # Use Hashids (a.k.a. Youtube-Like ID) in ActiveRecord seamlessly.
  acts_as_hashids

  belongs_to  :product
  has_many    :links

  delegate :name, to: :product, prefix: true, allow_nil: true

  monetize :price_cents
end
