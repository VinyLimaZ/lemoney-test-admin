# frozen_string_literal: true

module UrlValidator
  extend ActiveSupport::Concern

  included do
    private
    def url_valid?(url)
      uri = URI.parse(url)

      uri.is_a?(URI::HTTP) && uri.host.present?
    rescue URI::Error
      false
    end

    def sanitize_url(url_to_clean)
      new_url = url_to_clean.gsub(rgx_fetch_scheme_errors, '')
      "https://#{new_url}"
    end

    def rgx_fetch_scheme_errors
      # regex to look for a broken URL.
      # e.g htp://, ttp://, ://, //, /, ://* etc
      # will catch http:// and https:// too, but the sanitize_url method
      # will make URL great again, so don't bother with it
      %r{^\w*:?\/\W*}
    end
  end
end
