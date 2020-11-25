# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customer views purchased item', type: :system do  # 2.21 seconds
  subject { page }

  let!(:purchased_product)  { create(:product, :with_pictures_for_store, :with_consumables) }
  let!(:purchase)           { create(:purchase, :successful, product: purchased_product)    }

  before do
    visit store_purchase_path(purchase.to_param)
  end

  describe 'purchased item page' do
    it 'should show the purchased product' do
      expect(subject).to have_selector '#purchased-serial-number',  text: purchase.to_param
      expect(subject).to have_selector '#purchased-product-name',   text: purchased_product.name
      expect(subject).to have_selector '#purchased-product-intro',  text: purchased_product.intro
    end

    describe 'consumables' do
      it 'should show the consumable links' do
        expect(subject).to have_selector '.consumable-link', count: purchased_product.consumables.count
      end

      it 'should have the download button pointing to the valid url' do
        sample_link = purchase.links.first

        within('#consumable-link-0') do
          expect(subject).to have_link 'Download', href: store_link_path(sample_link.to_param)
        end
      end
    end
  end
end