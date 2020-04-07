# frozen_string_literal: true

feature 'Admin destroys an offer' do
  let!(:offer) { create(:offer, advertiser_name: 'lemoney') }
  let!(:offer_two) { create(:offer) }
  before { create_list(:offer, 3) }

  scenario 'and is redirected to index' do
    visit offers_path

    within "##{offer.advertiser_name}" do
      click_link 'Destroy offer'
    end

    expect(page).not_to have_text(offer.advertiser_name)
    expect(page).to have_text('Offer was successfully destroyed')
    expect(page).to have_text(offer_two.advertiser_name)
  end
end
