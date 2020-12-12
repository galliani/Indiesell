# frozen_string_literal: true

class CustomerMailerPreview < ActionMailer::Preview
  def purchase_completed_email
    purchase = OpenStruct.new(
      to_param: 'xadafafaf',
      product_name: 'Sample product',
      customer_email: 'good_customer@mockmail.com',
      price: '20.00',
      created_at: 1.hour.ago
    )

    CustomerMailer.purchase_completed_email(purchase)
  end
end