# frozen_string_literal: true

module Store
  class PurchasesController < ApplicationController
    layout 'store/application.html.erb'

    before_action :find_purchase, only: [:show, :success]

    def show
    end

    def create
      permitted_params  = params.require(:purchase).permit(:customer_email, :product_id)
      purchase          = Purchase.new(permitted_params)
      purchase.is_free  = purchase.product&.is_free

      if purchase.save
        CustomerMailer.completed_purchase_email(purchase: purchase).deliver_now

        flash[:notice] = 'Free purchase is successful!'

        redirect_to success_store_purchase_path(purchase)
      else
        flash[:alert] = 'Something is wrong with your free purchase'

        render '/'
      end
    end

    def success
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
