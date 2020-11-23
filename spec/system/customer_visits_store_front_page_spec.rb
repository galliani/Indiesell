# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customer visits store front page', type: :system, js: true do
  subject { page }

  let!(:live_products) { create_list(:product, 3) }
  let!(:draft_product) { create(:product, :draft) }

  before do
    visit root_path
  end

  describe 'store front page' do
    it 'should show ONLY the live products' do
      expect(subject).to have_text(live_products.first.name)
      expect(subject).to have_text(live_products.second.name)
      expect(subject).to have_text(live_products.third.name)

      expect(subject).to have_no_text(draft_product.name)
    end
  end

  describe 'product listed' do
    let(:sample_product) { live_products.first }

    it 'should display checkout button' do
      within("#product-#{sample_product.id}") do
        expect(subject).to have_css '.buynow'
      end
    end

    it 'should display product infos' do
      within("#product-#{sample_product.id}") do
        expect(subject).to have_selector  '.product-name',  text: sample_product.name
        expect(subject).to have_selector  '.product-price', text: sample_product.price
        expect(subject).to have_link      'More info',      href: store_product_path(sample_product)
      end
    end
  end
end