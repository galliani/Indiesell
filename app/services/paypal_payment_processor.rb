# frozen_string_literal: true

class PaypalPaymentProcessor
  def initialize
    @errors = []
  end

  attr_reader :errors

  def perform(purchase_params:)
    parsed_money = parse_money_from_amount(purchase_params)

    purchase                = build_purchase_from_params(purchase_params)
    purchase.price_cents    = parsed_money.fractional # 2000
    purchase.price_currency = parsed_money.currency.iso_code # USD

    purchase.links = ConsumableLinksCreator.new.perform(product: purchase.product)

    if purchase.save
      CustomerMailer.completed_purchase_email(purchase: purchase).deliver_now

      purchase
    else
      @errors = purchase.errors

      nil
    end
  end

  private

  def parse_money_from_amount(params)
    # Because price_cents is string of "20.00", we need to 
    # parse the string to money. To do that we need to build the compatible money string,
    # should be like "USD 20.00"
    money_string = "#{params[:price_currency]} #{params[:price_cents]}"

    Monetize.parse money_string
  end

  def build_purchase_from_params(params)
    purchase                      = Purchase.new
    purchase.gateway_id           = Gateway.find_by(name: 'Paypal').id
    purchase.gateway_customer_id  = params[:customer_id]
    purchase.customer_email       = params[:customer_email]
    purchase.product_id           = params[:product_id]
    purchase.token                = params[:token]
    purchase.is_paid              = params[:is_successful]

    purchase
  end
end