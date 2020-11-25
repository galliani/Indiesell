# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customer downloads purchased link', type: :system do # 2.79 seconds
  subject { page }

  let!(:purchased_product)  { create(:product, :with_pictures_for_store, :with_consumables) }
  let!(:purchase)           { create(:purchase, :successful, product: purchased_product)    }
  let!(:sample_link)        { purchase.links.first }

  before do
    # We want to test the download from 'store/links/:id' endpoint,
    # so it does not really matter if we stub the link url for the purpose of it
    stubbed_file_service_url = 'https://img-authors.flaticon.com/google.jpg'
    allow_any_instance_of(Link).to receive(:url).and_return(stubbed_file_service_url)

    visit store_purchase_path(purchase.to_param)
  end

  it 'should not raise any exception' do
    expect do
      within('#consumable-link-0') do
        click_on 'Download'
      end      
    end.to_not raise_error
  end
end