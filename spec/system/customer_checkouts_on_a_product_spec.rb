# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customer checkouts on a product', type: :system, js: true do # 26.64 seconds
  subject { page }

  let!(:product) { create(:product) }
  # SELECTORS
  let(:paypal_smart_button_iframe)  { 'iframe[title=PayPal]' }
  # use '[aria-label="Debit or Credit Card"]' or '.paypal-button-number-1'
  let(:paypal_pay_with_card_button) { '[aria-label="Debit or Credit Card"]' }
  let(:paypal_card_payment_iframe)  { 'iframe[title="paypal_card_fields"]' }

  before do
    visit root_path

    page.should have_selector('.paypal-buttons-context-iframe')
    page.should have_selector 'iframe'

    parent_iframe = find(paypal_smart_button_iframe)

    page.within_frame(parent_iframe) do
      page.should have_selector paypal_pay_with_card_button
      page.first(paypal_pay_with_card_button).click
      sleep(5)
      puts page.body

      page.should have_selector  paypal_card_payment_iframe
      @card_payment_iframe = find(paypal_card_payment_iframe)

      within_frame(@card_payment_iframe) do
        page.should have_selector  'form'

        within('form') do          
          fill_in_material_field '#credit-card-number',     with: ENV['paypal_mock_cc_no']
          fill_in_material_field '#expiry-date',            with: ENV['paypal_mock_cc_exp']
          fill_in_material_field '#credit-card-security',   with: ENV['paypal_mock_cc_cvv']
          
          # within '.billingAddress' div, the most reliable identifier is name attribute
          fill_in_material_field_by_name 'givenName',       with: 'First'
          fill_in_material_field_by_name 'familyName',      with: 'Customer'
          fill_in_material_field_by_name 'line1',           with: 'Address street 1'
          fill_in_material_field_by_name 'city',            with: 'Jakarta'
          select                         'Alaska',          from: 'state'
          fill_in_material_field_by_name 'postcode',        with: '12410'
          fill_in_material_field_by_name 'phone',           with: '2025550132'
          fill_in_material_field_by_name 'email',           with: 'customer_1@lorem.com'

          sleep(1)
          click_on 'Pay Now'
          sleep(3)
        end
      end
    end

    sleep(10)
  end

  describe 'payment success page' do
    it 'should be ok' do
      # The iframe should be gone by now
      expect(subject).to have_no_selector paypal_smart_button_iframe
      
      # Should be redirected to the /success payment page
      # describe 'payment success page'
      expect(subject).to have_selector   '#payment-success-message'
      expect(subject).to have_content    "#{product.price.currency.symbol}#{product.price.to_i}"

      # Sanity check
      new_purchase = Purchase.last
      expect(new_purchase.price_cents).to eq product.price_cents
      expect(new_purchase.price).to eq product.price
    end
  end

  # These methods are only used in the paypal checkout form for now,
  # so it makes more sense to be here to maximize the visibility
  def fill_in_material_field(key, with:)
    begin
      field = find(key).click # user usually click before input
    rescue Capybara::ElementNotFound
      field = find_field(key).click
    end

    field.send_keys with
  end

  def fill_in_material_field_by_name(key, with:)
    field = find_field(key).click

    field.send_keys with
  end
end
