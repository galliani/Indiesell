# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerMailer, type: :mailer do
  describe '#completed_purchase_email' do
    # payload:
    let(:sample_purchase) { create(:purchase, :successful) }
    # service:
    let(:mail) { described_class.completed_purchase_email(purchase: sample_purchase) }

    it 'is able to send the email' do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'should render the subject' do
      expected_subject = 
        "#{ENV['store_name']} - Thanks for completing the purchase of #{sample_purchase.product.name}"

      expect(mail.subject).to eq(expected_subject)
    end

    it 'should render the receiver email' do
      expect(mail.to).to eq([sample_purchase.customer_email])
    end

    it 'should render the sender email' do
      expect(mail.from).to eq([ENV['store_owner_email']])
    end

    describe 'email body' do
      it 'should contain these details' do
        expect(mail.body).to include "your purchase number: ##{sample_purchase.id.to_param}"
        expect(mail.body).to include sample_purchase.product.name
        expect(mail.body).to include "http://#{ENV['store_host']}:#{ENV['store_port']}/store/purchases/#{sample_purchase.to_param}"
      end
    end
  end
end
