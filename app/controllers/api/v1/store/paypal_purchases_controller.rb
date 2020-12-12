# frozen_string_literal: true

module API
  module V1
    module Store
      class PaypalPurchasesController < ApplicationController
        def create
          purchase_params = {
            price_cents:    params[:purchase_units][0][:amount][:value],
            price_currency: params[:purchase_units][0][:amount][:currency_code],
            product_id:     params[:purchase_units][0][:reference_id],
            token:          params[:orderID],
            customer_id:    params[:payer][:payer_id],
            customer_email: params[:payer][:email_address],
            is_successful:  params[:status] === 'COMPLETED'
          }

          purchase                      = Purchase.new
          purchase.gateway_id           = 1
          purchase.gateway_customer_id  = purchase_params[:customer_id]
          purchase.customer_email       = purchase_params[:customer_email]
          purchase.product_id           = purchase_params[:product_id]
          purchase.token                = purchase_params[:token]
          purchase.is_paid              = purchase_params[:is_successful]

          # Because price_cents is string of "20.00", we need to 
          # parse the string to money. To do that we need to build the compatible money string,
          # should be like "USD 20.00"
          money_string = "#{purchase_params[:price_currency]} #{purchase_params[:price_cents]}"
          parsed_money = Monetize.parse money_string

          purchase.price_cents          = parsed_money.fractional # 2000
          purchase.price_currency       = parsed_money.currency.iso_code # USD

          purchase.build_consumable_links

          if purchase.save
            CustomerMailer.completed_purchase_email(purchase: purchase).deliver_now

            render status: :ok, json: { purchase_code: purchase.id }
          else
            render status: :unprocessable_entity, json: {}
          end
        end
      end
    end
  end
end