# frozen_string_literal: true

module Store
  class PurchasesController < ApplicationController
    layout 'store/application.html.erb'

    def success
    end

    def failure
      render layout: false
    end
  end
end
