# frozen_string_literal: true

class Link < ApplicationRecord
  # Use Hashids (a.k.a. Youtube-Like ID) in ActiveRecord seamlessly.
  acts_as_hashids

  belongs_to :purchase
end
