# frozen_string_literal: true

module Store
  class LinksController < ApplicationController
    before_action :find_link

    def show
      require 'open-uri'

      download = open(@link.url) do |content|
        send_data content.read,
                  filename:     @link.filename,
                  content_type: @link.content_type
      end
    end

    private

    def find_link
      @link = Link.find(params[:id])
    end
  end
end
