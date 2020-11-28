source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby ">=2.6"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem 'mini_magick'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# ASSETS
gem 'bootstrap'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

# ADMINISTRATE
gem 'administrate'
gem 'administrate-field-enum'
gem 'administrate-field-active_storage', git: 'https://github.com/Dreamersoul/administrate-field-active_storage.git'
gem 'administrate-field-money'
# Currently there is a problem with the assets pipeline for the plugin below
# gem 'administrate-field-date_picker'

gem 'active_hash'
gem 'acts_as_hashids'
gem 'azure-storage'
gem 'clearance'
gem 'figaro'
gem 'money-rails'
gem 'ransack'
gem 'sucker_punch'
gem 'wannabe_bool'

# PAYMENT
 gem 'paypal-checkout-sdk'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'timecop'
  # Linters
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubycritic'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'capybara-selenium', '~> 0.0.6'
  gem 'selenium-webdriver', '3.142.7'
  gem 'rspec-retry'
  gem 'shoulda-matchers'
  gem 'simplecov', '0.16.1', require: false
  gem 'webmock'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'  
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
