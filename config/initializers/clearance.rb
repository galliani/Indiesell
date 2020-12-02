Clearance.configure do |config|
  config.routes                 = false
  config.allow_sign_up          = false
  config.mailer_sender          = ENV['store_owner_email']
  config.redirect_url           = '/admin'
  config.rotate_csrf_on_sign_in = true
  config.parent_controller      = '::Admin::ApplicationController' # IMPORTANT !!
end
