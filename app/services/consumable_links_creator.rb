# frozen_string_literal: true

class ConsumableLinksCreator
  def initialize
    @output = []
  end

  def perform(product:)
    product.consumables.each do |consumable|
      # To learn more about 'ActiveStorage::Current' block:
      # https://stackoverflow.com/questions/51110789/activestorage-service-url-rails-blob-path-cannot-generate-full-url-when-not-u
      ActiveStorage::Current.set(host: Rails.application.default_url_options[:host]) do
        @output << Link.new(
          blob_signed_id: consumable.signed_id,
          filename:       consumable.filename,
          content_type:   consumable.content_type,
          download_size:  consumable.byte_size,
          url:            consumable.service_url,
          expiry:         Time.now + ENV['file_expiry_hours'].to_i.hours,
        )
      end
    end

    @output
  end
end