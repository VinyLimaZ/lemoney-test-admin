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

  def destroy
    offer = find_offer
    offer.destroy

    redirect_to offers_path, notice: 'Offer was successfully destroyed'
  end

  def edit
    @offer = find_offer
  end

  def update
    @offer = find_offer

    if @offer.update(offer_params)
      redirect_to offers_path, notice: 'Offer was successfully updated'
    else
      @offer.reload
      render :edit
    end
  end

  def toggle_state
    @offer = find_offer

    if @offer.toggle_state!
      redirect_to offers_path, notice: 'State was successfully changed'
    else
      @offer.reload
      render :edit
    end
  end

  private
  def find_offer
    Offer.find(params[:id])
  end

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
