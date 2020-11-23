# frozen_string_literal: true

module Store
  class PurchasesController < ApplicationController
    layout 'store/application.html.erb'

    before_action :find_purchase, only: :success

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
