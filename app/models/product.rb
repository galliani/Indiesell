# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached  :display_picture
  has_many_attached :images
  has_many_attached :consumables

  monetize :price_cents

  scope :live, -> { where(is_live: true) }

  alias_attribute :intro, :description
end
