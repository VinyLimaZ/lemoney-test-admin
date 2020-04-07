# frozen_string_literal: true

feature 'Admin edits an offer' do
  let(:offer) { create(:offer, advertiser_name: 'another cashback company') }

  context 'with valids params' do
    scenario 'and is redirected to index' do
      visit edit_offer_path offer

      fill_in 'Advertiser name', with: 'Lemoney'
      fill_in 'URL', with: 'lemoney.com'
      fill_in 'Description', with: Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false)
      fill_in 'Date to start', with: Date.current
      fill_in 'Date to end', with: Date.current + 1.day
      check 'Premium'

      click_button 'Update offer'

      expect(page).to have_text('Offer was successfully updated')
      expect(page).to have_text('Lemoney')
      expect(page).to have_text('https://lemoney.com')
      expect(page).to have_text(Date.current)
    end
  end

  context 'with invalid or missing  params' do
    scenario 'they see the errors messages' do
      visit edit_offer_path offer

      fill_in 'Advertiser name', with: ''
      fill_in 'URL', with: ''
      fill_in 'Description', with: ''
      fill_in 'Date to start', with: ''
      fill_in 'Date to end', with: ''

      click_button 'Update offer'

      expect(page).to have_text('3 errors prohibited this offer from being saved')
      expect(page).to have_text("Advertiser name can't be blank")
      expect(page).to have_text("Description can't be blank")
      expect(page).to have_text("Date to start can't be blank")
    end
  end
end
