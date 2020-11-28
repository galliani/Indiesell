# frozen_string_literal: true

module API
  module V1
    module Store
      class PaypalPurchasesController < ApplicationController
        skip_before_action  :verify_authenticity_token

        def create
          # TODO
        end
      end
    end
  end
end