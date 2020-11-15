# frozen_string_literal: true

module PaypalPowered
  extend ActiveSupport::Concern

  def paypal_init
    client_id       = ENV['paypal_client_id']
    client_secret   = ENV['paypal_client_sec']
    environment     = PayPal::SandboxEnvironment.new client_id, client_secret

    @client         = PayPal::PayPalHttpClient.new environment
  end
end
