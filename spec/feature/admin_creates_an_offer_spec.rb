# frozen_string_literal: true

feature 'Admin creates an offer' do
  context 'missing all attributes' do
    scenario 'they see errors messages' do
      visit new_offer_path

      click_button 'Create offer'

      expect(page).to have_text('5 errors prohibited this offer from being saved')
      expect(page).to have_text("Advertiser name can't be blank")
      expect(page).to have_text("URL can't be blank")
      expect(page).to have_text('Invalid URL, please verify and try again')
      expect(page).to have_text("Description can't be blank")
      expect(page).to have_text("Date to start can't be blank")
    end
  end

  context 'with valid attributes' do
    scenario 'they see index with all offer including that one' do
      visit new_offer_path

      fill_in 'Advertiser name', with: 'Lemoney'
      fill_in 'URL', with: 'lemoney.com'
      fill_in 'Description', with: Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false)
      fill_in 'Date to start', with: Date.current
      fill_in 'Date to end', with: Date.current + 1.day
      check 'Premium'

      click_button 'Create offer'

      expect(page).to have_text('Lemoney')
      expect(page).to have_text('https://lemoney.com')
      expect(page).to have_text(Date.current)
    end
  end
end
