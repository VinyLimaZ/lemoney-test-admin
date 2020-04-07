# frozen_string_literal: true

class Offer < ApplicationRecord
  include UrlValidator

  validates :advertiser_name, :url, :description, :starts_at, presence: true
  validates :advertiser_name, uniqueness: true
  validates :description, length: { maximum: 500 }
  validate :verify_url

  def url=(raw_url)
    self[:url] = sanitize_url(raw_url) if raw_url.present?
  end

  private
  def verify_url
    return if url_valid?(url)

    add_url_errors
  end

  def add_url_errors
    errors.add(:url, :invalid_url)
  end
end
