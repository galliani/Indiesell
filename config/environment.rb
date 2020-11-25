# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Indiesell::Application.default_url_options = Indiesell::Application.config.action_mailer.default_url_options