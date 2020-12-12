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

          processor = PaypalPaymentProcessor.new
          purchase  = processor.perform(purchase_params: purchase_params)

          if purchase.persisted?
            render status: :ok, json: { purchase_code: purchase.id }
          else
            render status: :unprocessable_entity, json: { errors: processor.errors }
          end
        end
      end
    end
  end
end