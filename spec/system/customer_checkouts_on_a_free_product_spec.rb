# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customer checkouts on a free product', type: :system, js: true do # 26.64 seconds
  subject { page }

  let!(:product) { create(:product, :free) }

  describe 'product listed' do
    let(:sample_product) { live_products.first }

    it 'should display free download button' do
      within("#product-#{sample_product.id}") do
        expect(subject).to have_selector '.downloadnow'
      end
    end

    it 'should display product infos' do
      within("#product-#{sample_product.id}") do
        expect(subject).to have_selector  '.product-name',  text: sample_product.name
        expect(subject).to have_selector  '.product-price',
          text: "FREE"
      end
    end
  end

  context 'clicking Download button' do
    before do
      fill_in   :purchase_customer_email, with: 'customer_1@mail.com'
      click_on  'Get this free'
    end

    it 'should display thank you notification' do
      expect(subject).to have_content "Thank you, we'll send you the download link"
    end
  end
end
