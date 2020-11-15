# frozen_string_literal: true

module Store
  class PurchasesController < ApplicationController
    include PaypalPowered

    layout 'store/application.html.erb'

    before_action :find_purchase, only: :success
    before_action :paypal_init,   only: :success

    def success
      request       = PayPalCheckoutSdk::Orders::OrdersGetRequest::new(@purchase.token)
      response      = @client.execute request
      
      # To find out the what the response.result contains, you can view it in json format here:
      # spec/fixtures/paypal_order.json
      @order        = response.result  
    end

    def failure
      render layout: false
    end

    private

    def find_purchase
      @purchase = Purchase.find(params[:id])
    end
  end
end
