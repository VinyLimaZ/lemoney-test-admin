# frozen_string_literal: true

class OfferDecorator < ApplicationDecorator
  attr_reader :offer
  delegate_missing_to :offer

  def initialize(offer)
    @offer = offer
  end

  def state_to_s
    enabled? ? 'Enabled' : 'Disabled'
  end

  def opposite_state_to_s
    enabled? ? 'Disable' : 'Enable'
  end
end
