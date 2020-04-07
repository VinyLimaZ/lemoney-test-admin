# frozen_string_literal: true

class Offer < ApplicationRecord
  validates :advertiser_name, :url, :description, :starts_at, presence: true
  validates :advertiser_name, uniqueness: true
  validates :description, length: { maximum: 500 }
  validate :verify_url

  private
  def verify_url
    uri = URI.parse(url)
    return if uri.is_a?(URI::HTTP) && uri.host.present?

    add_url_errors
  rescue URI::InvalidURIError, URI::BadURIError
    add_url_errors
  end

  def add_url_errors
    errors.add(:url, :invalid_url)
  end
end
