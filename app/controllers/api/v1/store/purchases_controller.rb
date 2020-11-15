# frozen_string_literal: true

module API
  module V1
    module Store
      class PurchasesController < ApplicationController
        include PaypalPowered

        skip_before_action  :verify_authenticity_token
        before_action       :paypal_init

        def create
          params[:price_cents]    = '10.00'
          params[:price_currency] = 'USD'

          # PAYPAL CREATE ORDER
          request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
          request.request_body({
            intent: 'CAPTURE',
            purchase_units: [
              {
                amount: {
                  currency_code:  params[:price_currency],
                  value:          params[:price_cents]
                }
              }
            ]
          })

          response = @client.execute request

          purchase              = Purchase.new
          purchase.price_cents  = params[:price_cents]
          purchase.token        = response.result.id

          if purchase.save
            render  status: :ok,
                    json: { token: response.result.id }
          end
        end

        def capture
          # PAYPAL CAPTURE purchase
          request   = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new params[:paypal_order_id]
          response  = @client.execute request

          purchase          = Purchase.find_by token: params[:paypal_order_id]
          purchase.is_paid  = response.result.status == 'COMPLETED'

          if purchase.save
            render  status: :ok,
                    json: { purchase_code: purchase.id, status: response.result.status }
          end
        end

        private

        def paypal_init
          client_id       = ENV['paypal_client_id']
          client_secret   = ENV['paypal_client_sec']
          environment     = PayPal::SandboxEnvironment.new client_id, client_secret

          @client         = PayPal::PayPalHttpClient.new environment
        end
      end
    end
  end
end