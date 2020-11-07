# frozen_string_literal: true

module Store
  class ProductsController < ApplicationController
    layout 'store/application.html.erb'

    def index
      @products = Product.all        
    end
  end
end
