# frozen_string_literal: true

module API
  module V1
    module Store
      class PurchasesController < ApplicationController
        skip_before_action  :verify_authenticity_token

        def capture
          purchase                      = Purchase.new
          purchase.gateway_id           = 1
          purchase.gateway_customer_id  = params[:customer_id]
          purchase.customer_email       = params[:customer_email]
          purchase.product_id           = params[:product_id]
          purchase.price_cents          = params[:price_cents]
          purchase.price_currency       = params[:price_currency]
          purchase.token                = params[:token]
          purchase.is_paid              = params[:is_successful]

          if purchase.save
            render  status: :ok,
                    json: { purchase_code: purchase.id }
          else
            render  status: :unprocessable_entity, json: {}
          end
        end
      end
    end
  end
end