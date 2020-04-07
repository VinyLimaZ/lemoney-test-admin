# frozen_string_literal: true

class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      redirect_to offers_path, notice: 'Offer was successfully created.'
    else
      render :new
    end
  end

  private
  def offer_params
    params.require(:offer)
          .permit(:advertiser_name,
                  :url,
                  :description,
                  :starts_at,
                  :ends_at,
                  :premium)
  end
end
