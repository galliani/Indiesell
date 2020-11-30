# frozen_string_literal: true

module API
  module V1
    module Store
      class PaypalPurchasesController < ApplicationController
        skip_before_action  :verify_authenticity_token

        def create
          # TODO
          purchase                      = Purchase.new
          purchase.gateway_id           = 1
          purchase.gateway_customer_id  = params[:customer_id]
          purchase.customer_email       = params[:customer_email]
          purchase.product_id           = params[:product_id]
          purchase.token                = params[:token]
          purchase.is_paid              = params[:is_successful]

          # Because price_cents is string of "20.00", we need to 
          # parse the string to money. To do that we need to build the compatible money string,
          # should be like "USD 20.00"
          money_string = "#{params[:price_currency]} #{params[:price_cents]}"
          parsed_money = Monetize.parse money_string

          purchase.price_cents          = parsed_money.fractional # 2000
          purchase.price_currency       = parsed_money.currency.iso_code # USD

          if purchase.save
            render status: :ok, json: { purchase_code: purchase.id }
          else
            render status: :unprocessable_entity, json: {}
          end
        end
      end
    end
  end
end