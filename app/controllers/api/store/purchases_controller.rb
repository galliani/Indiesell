# frozen_string_literal: true

module API
  module Store
    class PurchasesController < ApplicationController
      skip_before_action :verify_authenticity_token

      before_action :paypal_init, :except => [:index]

      def index; end

      def create_purchase
        # PAYPAL CREATE ORDER
        price = '100.00'
        request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
        request.request_body({
          :intent => 'CAPTURE',
          :purchase_units => [
            {
              :amount => {
                :currency_code => 'USD',
                :value => price
              }
            }
          ]
        })
        begin
          response = @client.execute request
          purchase = Purchase.new
          purchase.price = price.to_i
          purchase.token = response.result.id
          if purchase.save
            return render :json => {:token => response.result.id}, :status => :ok
          end
        rescue PayPalHttp::HttpError => ioe
          # HANDLE THE ERROR
        end        
      end

      def capture_purchase
        # PAYPAL CAPTURE purchase
      end

      private

      def paypal_init
        client_id       = 'YOUR-CLIENT-ID'
        client_secret   = 'YOUR-CLIENT-SECRET'
        environment     = PayPal::SandboxEnvironment.new client_id, client_secret
        @client         = PayPal::PayPalHttpClient.new environment
      end
    end
  end
end