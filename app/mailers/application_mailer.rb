class ApplicationMailer < ActionMailer::Base
  default from: ENV['store_owner_email']
  layout 'mailer'
end
