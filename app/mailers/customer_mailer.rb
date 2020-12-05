class CustomerMailer < ActionMailer::Base
  def purchase_completed_email(purchase)
    @purchase = purchase

    mail(
      from:     "#{ENV['store_name']} <#{ENV['store_owner_email']}>",
      to:       @purchase.customer_email,
      subject:  "#{ENV['store_name']} - Thanks for completing the purchase of #{@purchase.product_name}"
    )
  end
end
